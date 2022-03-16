class Api::GreetingsController < ApplicationController
  def hello
    @message = 'Hello, how are you today?'
  end
end
