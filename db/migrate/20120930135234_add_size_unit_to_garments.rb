class AddSizeUnitToGarments < ActiveRecord::Migration
  def change
    add_column :garments, :size_unit, :string
  end
end
