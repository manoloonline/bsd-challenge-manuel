class TwitchSearchChannelsService < ApplicationService

  private_attr_reader :query_string

  def initialize(query_string)
    @query_string = query_string
  end

  def execute
    return [] unless query_string.present?

    response = Faraday.get(url, nil, headers)

    raise Net::HTTPBadResponse, "Bad search twitch API response status #{response.status}" unless response.success?

    JSON.parse(response.body)["data"]
  end



private

  def access_token
    response = Faraday.post("https://id.twitch.tv/oauth2/token?"\
                            "client_id=k2id2i9dftkfw4vrs6flyvy4zn6ktw&"\
                            "client_secret=rgar5nepwm49louf9sayybaq0kfvih&"\
                            "grant_type=client_credentials")

    raise Net::HTTPBadResponse, "Bad auth twitch API response status #{response.status}" unless response.success?

    JSON.parse(response.body)["access_token"]
  end

  def url
    "https://api.twitch.tv/helix/search/channels?query=#{query_string}"
  end

  def headers
    {
      'Authorization' => "Bearer #{access_token}",
      'Client-Id'     => 'k2id2i9dftkfw4vrs6flyvy4zn6ktw',
    }
  end
end