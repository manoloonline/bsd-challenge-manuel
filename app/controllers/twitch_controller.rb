# frozen_string_literal: true

class TwitchController < ApplicationController
  before_action :authenticate_user!

  def search
    result = TwitchSearchChannelsService.new(params['search_string'], current_user, params['cursor']).execute
    @records = result[:records]
    @search_string = result[:query_string]
    @cursor = result[:cursor]
  end
end
