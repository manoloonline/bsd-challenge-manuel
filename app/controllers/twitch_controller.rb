class TwitchController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @result = TwitchSearchChannelsService.new(params["search_string"]).execute
  end
end
