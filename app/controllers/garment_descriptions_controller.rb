class GarmentDescriptionsController < ApplicationController
  def index
    @garment_descriptions = GarmentDescription.all
  end

  def new
    @garment_description = GarmentDescription.new
  end

  def create
    @garment_description = GarmentDescription.new(params[:garment_description])

    if @garment_description.save
      redirect_to(@garment_description,
                  :notice => 'Garment description was successfully created.')
    else
      render :action => 'new'
    end
  end

  def show
    @garment_description = GarmentDescription.find(params[:id])
  end

  def edit
    @garment_description = GarmentDescription.find(params[:id])
  end
end
