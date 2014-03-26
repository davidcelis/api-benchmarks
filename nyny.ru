require File.expand_path('../config/environment.rb', __FILE__)
Bundler.setup(:default, :nyny)
require 'nyny'

class Wiggles < NYNY::App
  use ActiveRecord::ConnectionAdapters::ConnectionManagement
  before { headers['Content-Type'] = 'application/json' }

  namespace '/wiggles' do
    get '/' do
      Wiggle.all.to_json
    end

    get '/:id' do
      Wiggle.find(params[:id]).to_json
    end

    get '/:id/comments' do
      Wiggle.find(params[:id]).comments.to_json
    end
  end
end

Wiggles.run!
