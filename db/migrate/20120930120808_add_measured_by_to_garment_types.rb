class AddMeasuredByToGarmentTypes < ActiveRecord::Migration
  def change
    add_column :garment_types, :measured_by, :string
  end
end
