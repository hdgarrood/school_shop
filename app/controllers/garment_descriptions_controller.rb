class GarmentDescriptionsController < ApplicationController
  def index
    @garment_descriptions = GarmentDescription.all
  end

  def new
    @garment_description = GarmentDescription.new
  end
end
