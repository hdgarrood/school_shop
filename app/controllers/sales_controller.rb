require 'csv'

class SalesController < ApplicationController
  before_filter :find_garment,
                :only => [:create, :new]

  # show a list of sales. Will soon also export CSV
  def index
    @sold_garments = Garment.sold

    respond_to do |format|
      format.html # show.html.haml
      format.csv { render :layout => false }
    end
  end

  # 'create' a new sale (sells a garment)
  def create
    if @garment.sell(params[:garment][:price])
      flash[:notice] = t('garments.sold', :model => @garment)
      redirect_to @garment
    else
      handle_garment_already_sold
    end
  end
  
  # return a form for creating a new sale (ie selling a garment)
  def new
    handle_garment_already_sold if @garment.sold?
  end

  private
  def find_garment
    id = params[:garment_id] || (params[:garment] && params[:garment][:id])
    @garment = id ? Garment.find(id) : Garment.new
  end

  # Handle occasions where a user is trying to sell a garment which has already
  # been sold.
  def handle_garment_already_sold
    flash[:warning] = t('garments.already_sold')
    redirect_to @garment
  end
end
