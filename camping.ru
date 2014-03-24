require File.expand_path('../config/environment.rb', __FILE__)
Bundler.setup(:default, :camping)
require 'camping'

Camping.goes :Wiggles

module Wiggles
  module Controllers
    class Wiggles < R '/wiggles'
      def get
        ::Wiggle.all.to_json
      end
    end

    class Wiggle < R '/wiggles/(\d+)'
      def get(id)
        ::Wiggle.find(id).to_json
      end
    end

    class Comments < R '/wiggles/(\d+)/comments'
      def get(id)
        ::Wiggle.find(id).comments.to_json
      end
    end
  end
end

use ActiveRecord::ConnectionAdapters::ConnectionManagement
run Wiggles
