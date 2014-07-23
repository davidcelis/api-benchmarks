require File.expand_path('../config/environment.rb', __FILE__)
Bundler.setup(:default, :crepe)
require 'crepe'

class Benchmarks < Crepe::API
  respond_to :json

  get :empty

  namespace :numbers do
    param :count do
      let(:numbers) { (1..params[:count].to_i).to_a }

      get { numbers }
    end
  end
end

run Benchmarks
