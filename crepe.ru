require File.expand_path('../config/environment.rb', __FILE__)
Bundler.setup(:default, :crepe)
require 'crepe'

class WigglesAPI < Crepe::API
  respond_to :json

  namespace :wiggles do
    get { Wiggle.all.as_json }

    param :id do
      let(:wiggle) { Wiggle.find(params[:id]) }

      get { wiggle.as_json }

      get(:comments) { wiggle.comments.as_json }
    end
  end
end

use ActiveRecord::ConnectionAdapters::ConnectionManagement
run WigglesAPI
