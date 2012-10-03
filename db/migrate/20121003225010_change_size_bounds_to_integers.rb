class ChangeSizeBoundsToIntegers < ActiveRecord::Migration
  def up
    Garment.delete_all

    remove_column :garments, :size_lbound
    remove_column :garments, :size_ubound

    add_column :garments, :size_upper_bound, :integer
    add_column :garments, :size_lower_bound, :integer
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
