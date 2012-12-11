class SalesController < ApplicationController
  before_filter :find_garment,
                :only => [:create, :new]

  # show a list of sales. Will soon also export CSV
  def index
  end

  # 'create' a new sale (sells a garment)
  def create
    @garment.price = params[:garment][:price]
    @garment.sold_at = Time.now
    if @garment.save
      flash[:notice] = t('models.garment.sold', :model => @garment)
      redirect_to @garment
    end
  end
  
  # return a form for creating a new sale (ie selling a garment)
  def new
    if @garment.sold?
      flash[:warning] = t('models.garment.already_sold')
      redirect_to @garment
    end
  end

  private
  def find_garment
    id = params[:garment_id] || params[:garment][:id]
    @garment = Garment.find(id)
  end
end
