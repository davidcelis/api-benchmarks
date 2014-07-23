require File.expand_path('../config/environment.rb', __FILE__)
Bundler.setup(:default, :grape)
require 'grape'

class Benchmarks < Grape::API
  format :json

  get(:empty) { '' }

  namespace :numbers do
    params do
      requires :count, type: Integer, desc: 'How many numbers to render.'
    end
    route_param :count do
      get { (1..params[:count]).to_a }
    end
  end
end

run Benchmarks
