require File.expand_path('../config/environment.rb', __FILE__)
Bundler.setup(:default, :grape)
require 'grape'

class Wiggles < Grape::API
  format :json

  namespace :wiggles do
    get do
      Wiggle.all
    end

    params do
      requires :id, type: Integer, desc: 'Wiggle ID.'
    end
    route_param :id do
      get { Wiggle.find(params[:id]) }

      get(:comments) { Wiggle.find(params[:id]).comments }
    end
  end
end

use ActiveRecord::ConnectionAdapters::ConnectionManagement
run Wiggles
