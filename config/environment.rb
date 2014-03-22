$LOAD_PATH.unshift File.expand_path('../..', __FILE__)
ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require(:default)

ActiveSupport::Inflector.inflections do |inflect|
  inflect.acronym 'API'
end
