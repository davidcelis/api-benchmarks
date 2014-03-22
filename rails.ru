require File.expand_path('../config/environment.rb', __FILE__)
Bundler.setup(:default, :rails)

require 'rails/all'

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

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end

class WigglesController < ApplicationController
  respond_to :json

  # GET /posts.json
  def index
    respond_with Wiggle.all
  end

  # GET /posts/:id.json
  def show
    respond_with Wiggle.find(params[:id])
  end

  # GET /posts/:id/comments.json
  def comments
    respond_with Wiggle.find(params[:id]).comments
  end
end

Wiggles.initialize!

run Wiggles
