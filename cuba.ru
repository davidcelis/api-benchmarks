require File.expand_path('../config/environment.rb', __FILE__)
Bundler.setup(:default, :cuba)
require 'cuba'

Cuba.define do
  on get do
    on 'empty' do
      on root do
        res.headers['Content-Type'] = 'application/json; charset=utf-8'
        res.write ''
      end
    end

    on 'numbers' do
      on ':count' do |count|
        on root do
          res.headers['Content-Type'] = 'application/json; charset=utf-8'
          res.write (1..count.to_i).to_a.to_json
        end
      end
    end
  end
end

run Cuba
