class GarmentTypesController < ApplicationController
  def index
    @garment_types = GarmentType.all
  end

  def new
    @garment_type = GarmentType.new
  end

  def create
    @garment_type = GarmentType.new(params[:garment_type])

    if @garment_type.save
      redirect_to(@garment_type,
                  :notice => 'Garment type was successfully created.')
    else
      render :action => 'new'
    end
  end

  def show
    @garment_type = GarmentType.find(params[:id])
  end

  def edit
    @garment_type = GarmentType.find(params[:id])
  end

  def update
    @garment_type = GarmentType.find(params[:id])

    if @garment_type.update_attributes(params[:garment_type])
      redirect_to(@garment_type,
                 :notice => 'Garment type was successfully updated.')
    else
      render :action => 'edit'
    end 
  end

  def destroy
    @garment_type = GarmentType.find(params[:id])
    @garment_type.destroy
    redirect_to garment_types_url
  end
end
