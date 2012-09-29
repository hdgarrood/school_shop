class RenameGarmentDescriptionToGarmentType < ActiveRecord::Migration
  def change
    rename_column :garment_descriptions, :description, :type
    rename_table :garment_descriptions, :garment_types

    remove_index :garments, :garment_description_id
    rename_column :garments, :garment_description_id, :garment_type_id
    add_index :garments, :garment_type_id
  end
end
