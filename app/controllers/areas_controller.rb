#encoding: utf-8
class AreasController < ApplicationController
  respond_to :html, :js
  before_filter :find_area, :only => [:edit, :update, :destroy]
  def index
    @area = Area.new
    @areas = Area.all
  end

  def create
    @area = Area.new(params[:area])
    if @area.save_with_points
      redirect_to areas_path
    else
      @areas = Area.all
      @points_list = params[:area][:points_list]
      render :index
    end
  end

  def edit
    
    @area = Area.find params[:id]
    respond_with(@area) do |format|
      format.html{
        @areas = Area.all
        @points_list = @area.get_str_points
        render :index
      }
      format.js{ render :partial => 'areas/area' }
    end
    #render :partial => 'areas/area'
  end

  def update
    
    @area.attributes= params[:area]
    @area.points.destroy_all
    if @area.save_with_points
      redirect_to areas_path
    else
      @areas = Area.all
      @points_list = params[:area][:points_list]
      render :index
    end
  end

  def destroy
    @area.destroy
    redirect_to areas_path
  end

  def proximity_area
    @area, approximation = Area.get_since_point(params[:latitude], params[:longitude])
    respond_with(@area) do |format|
      format.html{
        @areas = Area.all
        @points_list = @area.get_str_points
        render :index
      }
      format.js{ render :text => "#{@area.id} => #{@area.title} => #{approximation ? "APPROXIMATION" : "IN" }" }
    end
  end

  private
  def find_area
    @area = Area.find(params[:id])
  end

end