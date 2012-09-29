class AddSizeLboundAndSizeUboundToGarments < ActiveRecord::Migration
  def change
    add_column :garments, :size_lbound, :float
    add_column :garments, :size_ubound, :float
  end
end
