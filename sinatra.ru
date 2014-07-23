require File.expand_path('../config/environment.rb', __FILE__)
Bundler.setup(:default, :sinatra)

require 'sinatra/base'

class Benchmarks < Sinatra::Base
  get('/empty') { '' }

  get('/numbers/:count') { (1..params[:count].to_i).to_a.to_json }
end

run Benchmarks
