class Keyword < ActiveRecord::Base
  belongs_to :category
  validates_presence_of :words
end
