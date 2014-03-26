require File.expand_path('../config/environment.rb', __FILE__)
Bundler.setup(:default, :hobbit)
require 'hobbit'

class Wiggles < Hobbit::Base
  get '/wiggles' do
    Wiggle.all.to_json
  end

  get '/wiggles/:id' do
    Wiggle.find(request.params[:id]).to_json
  end

  get '/wiggles/:id/comments' do
    Wiggle.find(request.params[:id]).comments.to_json
  end
end

use ActiveRecord::ConnectionAdapters::ConnectionManagement
run Wiggles.new
