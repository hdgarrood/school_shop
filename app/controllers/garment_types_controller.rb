class GarmentTypesController < ApplicationController
  before_filter :find_garment_type_from_params,
                :only => [:show, :edit, :update, :destroy]

  def index
    @garment_types = GarmentType.all.sort_by(&:name)
  end

  def new
    @garment_type = GarmentType.new
  end

  def create
    @garment_type = GarmentType.new(params[:garment_type])

    if @garment_type.save
      flash[:notice] = t('garment_types.created')
      redirect_to @garment_type
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
      flash[:notice] = t('garment_types.updated')
      redirect_to @garment_type
    else
      render :action => 'edit'
    end 
  end

  def destroy
    if @garment_type.garments.empty?
      @garment_type.destroy
      redirect_to garment_types_path
    else
      flash[:error] = t('garment_types.cannot_delete_with_children')
      redirect_to @garment_type
    end
  end
  
  protected
  def find_garment_type_from_params
    @garment_type = GarmentType.find(params[:id])
  end
end
