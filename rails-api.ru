require File.expand_path('../config/environment.rb', __FILE__)
Bundler.setup(:default, 'rails-api')

require 'active_record/railtie'
require 'action_controller/railtie'
require 'rails-api'

class Wiggles < Rails::Application
  routes.append do
    resources :wiggles, only: [:show, :index] do
      get :comments, on: :member, as: :wiggle_comments
    end
  end

  config.cache_classes   = true
  config.eager_load      = true
  config.log_level       = :error
  config.secret_key_base = 'not_so_secret_key_base'
end

class WigglesController < ActionController::API
  # GET /wiggles.json
  def index
    render json: Wiggle.all
  end

  # GET /wiggles/:id.json
  def show
    render json: Wiggle.find(params[:id])
  end

  # GET /wiggles/:id/comments.json
  def comments
    render json: Wiggle.find(params[:id]).comments
  end
end

Wiggles.initialize!

run Wiggles
