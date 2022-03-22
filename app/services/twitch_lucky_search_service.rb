# frozen_string_literal: true

class TwitchLuckySearchService < TwitchSearchChannelsService
  def execute
    loop do
      response = results

      raise Net::HTTPBadResponse, "Bad search twitch API response status #{response.status}" unless response.success?

      JSON.parse(response.body)['data'].each do |twitcher|
        unless result_duplicated? twitcher
          add_history(current_user, [twitcher['id']])
          return [twitcher]
        end
      end
    end
  end

  private

  def results
    Faraday.get(url, nil, headers)
  end

  def url
    "#{API_SEARCH}?query=#{('aaa'..'zzz').to_a.sample}&first=100"
  end

  def result_duplicated?(result)
    $redis.zrevrange("history:#{current_user.id}", 0, -1).include? result
  end
end
