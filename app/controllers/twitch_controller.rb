# frozen_string_literal: true

class TwitchController < ApplicationController
  before_action :authenticate_user!

  def search
    result = TwitchSearchChannelsService.execute(params['search_string'], current_user, params['cursor'])
    @records = result[:records]
    @search_string = result[:query_string]
    @cursor = result[:cursor]
  end

  def lucky
    @records = TwitchLuckySearchService.execute(params['search_string'], current_user, params['cursor'])
    render "search"
  end
end
