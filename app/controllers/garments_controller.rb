class GarmentsController < ApplicationController
  before_filter :find_garment,
                :only => [:show, :update, :destroy, :edit]

  before_filter :find_garment_types,
                :only => [:new, :create]

  def index
  end

  def new
    @garment = Garment.new
  end

  def create
    @garment = Garment.new(params[:garment])
    if @garment.save
      flash[:notice] = t(:notice_successful_create, :model => @garment)
      redirect_to @garment
    else
      render :action => 'new'
    end
  end

  def show
  end

  private
  def find_garment
    @garment = Garment.find(params[:id])
  end

  def find_garment_types
    @garment_types = GarmentType.all
  end
end
