require File.expand_path('../config/environment.rb', __FILE__)
Bundler.setup(:default, 'rails-api')

require 'action_controller/railtie'
require 'rails-api'

class Benchmarks < Rails::Application
  routes.append do
    get '/empty',          to: 'benchmarks#empty'
    get '/numbers/:count', to: 'benchmarks#numbers'
  end

  config.cache_classes   = true
  config.eager_load      = true
  config.log_level       = :error
  config.secret_key_base = 'not_so_secret_key_base'
end

class BenchmarksController < ActionController::API
  # GET /empty
  def empty
    render nothing: true
  end

  # GET /numbers/:count
  def numbers
    render json: (1..params[:count].to_i).to_a
  end
end

Benchmarks.initialize!

run Benchmarks
