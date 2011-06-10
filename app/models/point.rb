#encoding: utf-8
class Point < ActiveRecord::Base
  acts_as_list :scope => :area
  belongs_to :area

  validates :latitude, :presence => true
  validates :longitude, :presence => true
end