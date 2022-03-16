class TwitchController < ApplicationController

  def search
    @result = TwitchSearchChannelsService.new(params["search_string"]).execute
  end
end
