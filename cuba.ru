require File.expand_path('../config/environment.rb', __FILE__)
Bundler.setup(:default, :cuba)
require 'cuba'

Cuba.define do
  on get, 'empty' do
    res.headers['Content-Type'] = 'application/json; charset=utf-8'
    res.write ''
  end

  on get, 'numbers/:count' do |count|
    res.headers['Content-Type'] = 'application/json; charset=utf-8'
    res.write (1..count.to_i).to_a.to_json
  end
end

run Cuba
