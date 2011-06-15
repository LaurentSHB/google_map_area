#encoding: utf-8
require 'test_helper'

class PointTest < ActiveSupport::TestCase

  def setup
    @p1 = {:x => 1,   :y => 1, :area => 1}
    @p1_1 = {:x => 2,   :y => 1, :area => 1}
    @p1_2 = {:x => 2.5,   :y => 1, :area => 1}
    @p1_3 = {:x => 1,   :y => 2, :area => 1}
    @p1_4 = {:x => 2,   :y => 2, :area => 1}
    @p1_5 = {:x => 2.5,   :y => 2, :area => 1}
    @p2 = {:x => 1,   :y => 3, :area => 1}
    @p2 = {:x => 1,   :y => 3, :area => 1}
    @p3 = {:x => 1.5, :y => 3.5, :area => 1}
    @p4 = {:x => 3.5,   :y => 4, :area => 1}
    @p5 = {:x => 3.5,   :y => 6, :area => 1}
    @p6 = {:x => 3.5,   :y => 7, :area => 3}
    @p7 = {:x => 6,   :y => 7, :area => 3}
    @p8 = {:x => 6.5,   :y => 6.5, :area => 3}
    @p9 = {:x => 7.5,   :y => 6, :area => 3}
    @p10 = {:x => 8.5,  :y => 5, :area => 2}
    @p11 = {:x => 5.5,  :y => 5.5, :area => 3}
    @p12 = {:x => 5.5,  :y => 6, :area => 3}
    @p13 = {:x => 6.5,  :y => 3.5, :area => 2}
    @p14 = {:x => 4,  :y => 1, :area => 1}
    @p15 = {:x => 12,  :y => 4.5, :area => 2}
    @p16 = {:x => 9.5,  :y => 9, :area => 3}
    @p17 = {:x => 1.5,  :y => 8.5, :area => 1}
    @p18 = {:x => 9.5,  :y => 1.5, :area => 2}
    @p19 = {:x => 3,  :y => 3.5, :area => 1}
    @p20 = {:x => 2.5,  :y => 2, :area => 1}
  end


  test "if distance si well calculated between a segment and a point" do
    a = points(:A)
    b = points(:B)
    c = points(:C)
    d = points(:D)
    e = points(:E)


    assert_equal Math.sqrt(2), Point.get_distance_to_segment(a, e, @p1[:y], @p1[:x])
    assert_equal 1, Point.get_distance_to_segment(a, e, @p1_1[:y], @p1_1[:x])
    assert_equal 1, Point.get_distance_to_segment(a, e, @p1_2[:y], @p1_2[:x])
    assert_equal 1, Point.get_distance_to_segment(a, e, @p1_3[:y], @p1_3[:x])
    assert_equal 0, Point.get_distance_to_segment(a, e, @p1_4[:y], @p1_4[:x])
    assert_equal 0, Point.get_distance_to_segment(a, e, @p1_5[:y], @p1_5[:x])


    assert_equal Math.sqrt(2), Point.get_distance_to_segment(a, b, @p1[:y], @p1[:x])
    assert_equal 3, Point.get_distance_to_segment(b, c, @p1[:y], @p1[:x])
    assert_equal 5, Point.get_distance_to_segment(c, d, @p1[:y], @p1[:x])



    d_p2 = Point.get_distance_to_segment(a, b, @p2[:y], @p2[:x])
    assert d_p2 > 0.35 &&  d_p2 < 0.45
    # P1
    #    assert_equal @p1[:area], Area.get_close_to_point(@p1[:y],@p1[:x]).id
    #    assert_equal @p2[:area] , Area.get_close_to_point(@p2[:y],@p2[:x]).id
    #    assert_equal @p3[:area] , Area.get_close_to_point(@p3[:y],@p3[:x]).id
    #    assert_equal @p4[:area] , Area.get_close_to_point(@p4[:y],@p4[:x]).id
    #    assert_equal @p5[:area] , Area.get_close_to_point(@p5[:y],@p5[:x]).id
    #    assert_equal @p6[:area] , Area.get_close_to_point(@p6[:y],@p6[:x]).id
    #    assert_equal @p7[:area] , Area.get_close_to_point(@p7[:y],@p7[:x]).id
    #    assert_equal @p8[:area] , Area.get_close_to_point(@p8[:y],@p8[:x]).id
    #    assert_equal @p9[:area] , Area.get_close_to_point(@p9[:y],@p9[:x]).id
    #    assert_equal @p10[:area] , Area.get_close_to_point(@p10[:y],@p10[:x]).id
    #    assert_equal @p11[:area] , Area.get_close_to_point(@p11[:y],@p11[:x]).id
    #    assert_equal @p12[:area] , Area.get_close_to_point(@p12[:y],@p12[:x]).id
    #    assert_equal @p13[:area] , Area.get_close_to_point(@p13[:y],@p13[:x]).id
    #    assert_equal @p14[:area] , Area.get_close_to_point(@p14[:y],@p14[:x]).id
    #    assert_equal @p15[:area] , Area.get_close_to_point(@p15[:y],@p15[:x]).id
    #    assert_equal @p16[:area] , Area.get_close_to_point(@p16[:y],@p16[:x]).id
    #    assert_equal @p17[:area] , Area.get_close_to_point(@p17[:y],@p17[:x]).id
    #    assert_equal @p18[:area] , Area.get_close_to_point(@p18[:y],@p18[:x]).id
    #    assert_equal @p19[:area] , Area.get_close_to_point(@p19[:y],@p19[:x]).id
    #    assert_equal @p20[:area] , Area.get_close_to_point(@p20[:y],@p20[:x]).id
  end
end