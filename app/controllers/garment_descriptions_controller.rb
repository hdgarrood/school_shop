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

  def update
    @garment_description = GarmentDescription.find(params[:id])

    if @garment_description.update_attributes(params[:garment_description])
      redirect_to(@garment_description,
                 :notice => 'Garment description was successfully updated.')
    else
      render :action => 'edit'
    end 
  end

  def destroy
    @garment_description = GarmentDescription.find(params[:id])
    @garment_description.destroy
    redirect_to garment_descriptions_url
  end
end
