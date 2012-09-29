class RenameTypeToName < ActiveRecord::Migration
  def change
    rename_column :garment_types, :type, :name
  end
end
