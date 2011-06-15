#encoding: utf-8
require 'test_helper'

class AreaTest < ActiveSupport::TestCase

  def setup
    @p1 = {:x => 1,   :y => 1, :area => 1}
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


  test "if points are correctly affected to an area" do
    a1 = areas(:area_one)
    a2 = areas(:area_two)
    a3 = areas(:area_three)

    assert_equal 5, a1.points.count
    assert_equal 5, a2.points.count
    assert_equal 6, a3.points.count

    assert_equal Math.sqrt(2), a1.get_distance_to_point(@p1[:y], @p2[:x])
    d_p1_a2 = a2.get_distance_to_point(@p1[:y], @p2[:x])
    assert 3.9 < d_p1_a2 && d_p1_a2 < 3.95
    d_p1_a3 = a3.get_distance_to_point(@p1[:y], @p2[:x])
    assert 5.6 < d_p1_a3 && d_p1_a3 < 5.7


    # P1
    assert_equal @p1[:area], Area.get_close_to_point(@p1[:y],@p1[:x]).id
    assert_equal @p2[:area] , Area.get_close_to_point(@p2[:y],@p2[:x]).id
    assert_equal @p3[:area] , Area.get_close_to_point(@p3[:y],@p3[:x]).id
    assert_equal @p4[:area] , Area.get_close_to_point(@p4[:y],@p4[:x]).id
    assert_equal @p5[:area] , Area.get_close_to_point(@p5[:y],@p5[:x]).id
    assert_equal @p6[:area] , Area.get_close_to_point(@p6[:y],@p6[:x]).id
    assert_equal @p7[:area] , Area.get_close_to_point(@p7[:y],@p7[:x]).id
    assert_equal @p8[:area] , Area.get_close_to_point(@p8[:y],@p8[:x]).id
    assert_equal @p9[:area] , Area.get_close_to_point(@p9[:y],@p9[:x]).id
    assert_equal @p10[:area] , Area.get_close_to_point(@p10[:y],@p10[:x]).id
    assert_equal @p11[:area] , Area.get_close_to_point(@p11[:y],@p11[:x]).id
    assert_equal @p12[:area] , Area.get_close_to_point(@p12[:y],@p12[:x]).id
    assert_equal @p13[:area] , Area.get_close_to_point(@p13[:y],@p13[:x]).id
    assert_equal @p14[:area] , Area.get_close_to_point(@p14[:y],@p14[:x]).id
    assert_equal @p15[:area] , Area.get_close_to_point(@p15[:y],@p15[:x]).id
    assert_equal @p16[:area] , Area.get_close_to_point(@p16[:y],@p16[:x]).id
    assert_equal @p17[:area] , Area.get_close_to_point(@p17[:y],@p17[:x]).id
    assert_equal @p18[:area] , Area.get_close_to_point(@p18[:y],@p18[:x]).id
    assert_equal @p19[:area] , Area.get_close_to_point(@p19[:y],@p19[:x]).id
    assert_equal @p20[:area] , Area.get_close_to_point(@p20[:y],@p20[:x]).id
  end
end