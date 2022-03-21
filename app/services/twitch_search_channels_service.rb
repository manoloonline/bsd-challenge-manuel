# frozen_string_literal: true

class TwitchSearchChannelsService < ApplicationService
  private_attr_reader :query_string, :cursor, :current_user

  API_SEARCH = 'https://api.twitch.tv/helix/search/channels'

  @@access_token = nil
  @@expiration_token = Time.now

  def initialize(query_string, current_user, cursor = nil)
    @query_string = query_string
    @cursor = cursor
    @current_user = current_user
  end

  def execute
    return {records:[], query_string: query_string, cursor:nil} unless query_string.present?

    response = Faraday.get(url, nil, headers)

    raise Net::HTTPBadResponse, "Bad search twitch API response status #{response.status}" unless response.success?

    current_user.update!(last_search: query_string)

    { records: JSON.parse(response.body)['data'],
      query_string: query_string,
      cursor: JSON.parse(response.body)['pagination']['cursor']}
  end

  private

  def access_token
    return @@access_token if @@expiration_token > Time.now && @@access_token

    response = Faraday.post('https://id.twitch.tv/oauth2/token?'\
                            "client_id=#{Rails.application.credentials.dig(:twitch, :client_id)}&"\
                            "client_secret=#{Rails.application.credentials.dig(:twitch, :client_secret)}&"\
                            'grant_type=client_credentials')

    raise Net::HTTPBadResponse, "Bad auth twitch API response status #{response.status}" unless response.success?

    @@expiration_token = Time.now + JSON.parse(response.body)['expires_in'].to_i.seconds
    @@access_token = JSON.parse(response.body)['access_token']
  end

  def url
    "#{API_SEARCH}?query=#{query_string}&after=#{cursor}"
  end

  def headers
    {
      'Authorization' => "Bearer #{access_token}",
      'Client-Id' => Rails.application.credentials.dig(:twitch, :client_id)
    }
  end
end
