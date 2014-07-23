require File.expand_path('../config/environment.rb', __FILE__)
Bundler.setup(:default, :hobbit)
require 'hobbit'

class Benchmarks < Hobbit::Base
  get '/empty' do
    response.headers['Content-Type'] = 'application/json; charset=utf-8'
    ''
  end

  get '/numbers/:count' do
    response.headers['Content-Type'] = 'application/json; charset=utf-8'
    (1..request.params[:count].to_i).to_a.to_json
  end
end

run Benchmarks.new
