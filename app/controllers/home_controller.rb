#encoding: utf-8
class HomeController < ApplicationController

  def index
    @area = Area.new
  end

end