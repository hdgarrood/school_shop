class GarmentDescriptionsController < ApplicationController
  def index
    @garment_descriptions = GarmentDescription.all
  end
end
