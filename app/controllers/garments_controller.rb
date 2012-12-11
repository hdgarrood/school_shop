class GarmentsController < ApplicationController
  before_filter :find_garment,
                :only => [:show, :update, :destroy, :edit, :sell]

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
      flash[:notice] = t('garments.created', :model => @garment)
      redirect_to @garment
    else
      render :action => 'new'
    end
  end

  def show
  end

  def sell
    if request.put?
      @garment.price = params[:garment][:price]
      @garment.sold_at = Time.now
      if @garment.save
        flash[:notice] = t('garments.sold', :model => @garment)
        redirect_to @garment
      end
    elsif request.get? && @garment.sold?
      flash[:warning] = t('garments.already_sold')
      redirect_to @garment
    end
  end

  private
  def find_garment
    @garment = Garment.find(params[:id])
  end

  def find_garment_types
    @garment_types = GarmentType.all
  end
end
