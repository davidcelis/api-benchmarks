require File.expand_path('../config/environment.rb', __FILE__)
Bundler.setup(:default, :hobbit)
require 'hobbit'

class Wiggles < Hobbit::Base
  get '/wiggles' do
    response.headers['Content-Type'] = 'application/json; charset=utf-8'
    Wiggle.all.to_json
  end

  get '/wiggles/:id' do
    response.headers['Content-Type'] = 'application/json; charset=utf-8'
    Wiggle.find(request.params[:id]).to_json
  end

  get '/wiggles/:id/comments' do
    response.headers['Content-Type'] = 'application/json; charset=utf-8'
    Wiggle.find(request.params[:id]).comments.to_json
  end
end

use ActiveRecord::ConnectionAdapters::ConnectionManagement
run Wiggles.new
