class GarmentsController < ApplicationController
  def index
  end

  def new
    @garment = Garment.new
  end
end
