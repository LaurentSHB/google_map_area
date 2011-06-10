#encoding: utf-8
class AreasV2Controller < ApplicationController

  def index
    @area = Area.new
    @areas = Area.all
    render :layout => "application_v2"
  end

  def create
    @area = Area.new(params[:area])
    if @area.save_with_points
      redirect_to areas_path
    else
      render :index
    end
  end

end