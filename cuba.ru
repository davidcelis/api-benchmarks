require File.expand_path('../config/environment.rb', __FILE__)
Bundler.setup(:default, :cuba)
require 'cuba'

Cuba.use ActiveRecord::ConnectionAdapters::ConnectionManagement

Cuba.define do
  on get do
    on 'wiggles' do
      on root do
        res.headers['Content-Type'] = 'application/json; charset=utf-8'
        res.write Wiggle.all.to_json
      end

      on ':id' do |id|
        wiggle = Wiggle.find(id)

        on root do
          res.headers['Content-Type'] = 'application/json; charset=utf-8'
          res.write wiggle.to_json
        end

        on 'comments' do
          res.headers['Content-Type'] = 'application/json; charset=utf-8'
          res.write wiggle.comments.to_json
        end
      end
    end
  end
end

run Cuba
