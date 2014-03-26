require File.expand_path('../config/environment.rb', __FILE__)
Bundler.setup(:default, 'rails-metal')

require 'rails'
require 'rails/all'

class Wiggles < Rails::Application
  routes.append do
    get '/wiggles',              to: WigglesController.action(:index)
    get '/wiggles/:id',          to: WigglesController.action(:show)
    get '/wiggles/:id/comments', to: WigglesController.action(:comments)
  end

  config.cache_classes   = true
  config.eager_load      = true
  config.log_level       = :error
  config.secret_key_base = 'not_so_secret_key_base'
end

class WigglesController < ActionController::Metal
  # GET /wiggles.json
  def index
    self.content_type  = 'application/json; charset=utf-8'
    self.response_body = Wiggle.all.to_json
  end

  # GET /wiggles/:id.json
  def show
    self.content_type  = 'application/json; charset=utf-8'
    self.response_body = Wiggle.find(params[:id]).to_json
  end

  # GET /wiggles/:id/comments.json
  def comments
    self.content_type  = 'application/json; charset=utf-8'
    self.response_body = Wiggle.find(params[:id]).comments.to_json
  end
end

Wiggles.initialize!

run Wiggles
