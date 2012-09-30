class GarmentsController < ApplicationController
  before_filter :find_garment,
                :only => [:show, :update, :destroy, :edit]

  def index
  end

  def new
    @garment = Garment.new
    @garment_types = GarmentType.all
  end

  def create
    @garment = Garment.new(params[:garment])
    if @garment.save
      flash[:notice] = "Garment added."
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
end
