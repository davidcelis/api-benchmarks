require File.expand_path('../config/environment.rb', __FILE__)
Bundler.setup(:default, 'rails-metal')

require 'rails'
require 'action_controller/railtie'

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

class BenchmarksController < ActionController::Metal
  # GET /empty
  def empty
    self.content_type  = 'application/json; charset=utf-8'
    self.response_body = ''
  end

  # GET /numbers/:count
  def numbers
    self.content_type  = 'application/json; charset=utf-8'
    self.response_body = (1..params[:count].to_i).to_a.to_json
  end
end

Benchmarks.initialize!

run Benchmarks
