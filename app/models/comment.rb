require 'app/models/wiggle'

class Comment < ActiveRecord::Base
  belongs_to :wiggle
end
