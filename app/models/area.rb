#encoding: utf-8
class Area < ActiveRecord::Base
  attr_accessor :points_list
  has_many :points, :order => "position ASC", :dependent => :destroy

  validates :title, :presence => true
  def save_with_points
    if self.valid?
      coordinates = self.points_list.to_s.split(";")
      coordinates.each_with_index do |coord, idx|
        c = coord.split(",")
        p = Point.new(:latitude => c[0], :longitude => c[1], :position => idx + 1)
        if p.valid?
          self.points << p
        else
          self.errors.add(:points, "point #{idx + 1} erroné => #{p.errors}")
        end

      end
      if self.errors.blank?
        self.save
      end
    end
  end

  def get_ary_points
    ary = []
    self.points.each do |point|
      ary << [point.latitude, point.longitude]
    end
    ary
  end

  def get_str_points
    get_ary_points.collect{|points| points.join(",")}.join(";")
  end

  def self.get_since_point(latitude, longitude)
    return Area.find(1), true
  end
end