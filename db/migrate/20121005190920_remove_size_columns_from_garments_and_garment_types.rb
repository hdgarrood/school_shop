class RemoveSizeColumnsFromGarmentsAndGarmentTypes < ActiveRecord::Migration
  def change
    remove_column :garments, :size_lower_bound
    remove_column :garments, :size_upper_bound
    remove_column :garments, :size_unit

    remove_column :garment_types, :measured_by
  end
end
