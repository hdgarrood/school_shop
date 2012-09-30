class GarmentTypesController < ApplicationController
  before_filter :find_garment_type_from_params,
                :only => [:show, :edit, :update, :delete]

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
  end

  def edit
  end

  def update
    if @garment_type.update_attributes(params[:garment_type])
      redirect_to(@garment_type,
                 :notice => 'Garment type was successfully updated.')
    else
      render :action => 'edit'
    end 
  end

  def destroy
    @garment_type.destroy
    redirect_to garment_types_url
  end
  
  protected
  def find_garment_type_from_params
    @garment_type = GarmentType.find(params[:id])
  end
end
