class GarmentsController < ApplicationController
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
end
