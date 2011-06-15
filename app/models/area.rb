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

  def self.get_close_to_point(latitude, longitude)
    distance = 9999999999.0
    result_area = nil
    Area.all.each do |area|
      val = area.get_distance_to_point(latitude, longitude)
      if val < distance
        distance = val
        result_area = area
      end
    end
    return result_area, distance
  end

  def get_distance_to_point(latitude, longitude)
    my_points = self.points
    i = 0
    distance = 99999999999999.0
    while i < my_points.length
      if i + 1  == my_points.length
        val = Point.get_distance_to_segment(my_points[i], my_points[0], latitude, longitude)
      else
        val = Point.get_distance_to_segment(my_points[i], my_points[i+1], latitude, longitude)
      end
      if val < distance
        distance = val
      end
      i += 1
    end
    distance
  end
  #  def inside_polygon?(point)
  #
  #      counter = 0;
  #
  #      p1 = @polygon[0]
  #      i = 1
  #      @polygon.each do
  #        p2 = @polygon[i % nombre_points]
  #        if (point.y > MIN(p1.y,p2.y))
  #          if (point.y <= MAX(p1.y,p2.y))
  #            if (point.x <= MAX(p1.x,p2.x))
  #              if (p1.y != p2.y)
  #                xinters = (point.y-p1.y)*(p2.x-p1.x)/(p2.y-p1.y)+p1.x;
  #                if (p1.x == p2.x || p.x <= xinters)
  #                  counter = counter + 1
  #                end
  #              end
  #            end
  #          end
  #        end
  #        i = i+1
  #        p1 = p2
  #      end
  #
  #      if (counter % 2 == 0)
  #        return false
  #      else
  #        return true
  #      end
  #
  #    end
end