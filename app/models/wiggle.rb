require 'app/models/comment'

class Wiggle < ActiveRecord::Base
  has_many :comments
end
