class GarmentsController < ApplicationController
  def index
  end

  def new
    @garment = Garment.new
    @garment_types = GarmentType.all
  end
end
