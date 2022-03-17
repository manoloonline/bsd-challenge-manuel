# frozen_string_literal: true

class TwitchSearchChannelsService < ApplicationService
  private_attr_reader :query_string

  @@access_token = nil
  @@expiration_token = Time.now

  def initialize(query_string)
    @query_string = query_string
  end

  def execute
    return [] unless query_string.present?

    response = Faraday.get(url, nil, headers)

    raise Net::HTTPBadResponse, "Bad search twitch API response status #{response.status}" unless response.success?

    JSON.parse(response.body)['data']
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
    "https://api.twitch.tv/helix/search/channels?query=#{query_string}"
  end

  def headers
    {
      'Authorization' => "Bearer #{access_token}",
      'Client-Id' => Rails.application.credentials.dig(:twitch, :client_id)
    }
  end
end
