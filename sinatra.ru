require File.expand_path('../config/environment.rb', __FILE__)
Bundler.setup(:default, :sinatra)

require 'sinatra/base'

class Wiggles < Sinatra::Base
  get '/wiggles' do
    Wiggle.all.to_json
  end

  get '/wiggles/:id' do
    Wiggle.find(params[:id]).to_json
  end

  get '/wiggles/:id/comments' do
    Wiggle.find(params[:id]).comments.to_json
  end
end

use ActiveRecord::ConnectionAdapters::ConnectionManagement
run Wiggles
