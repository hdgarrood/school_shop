class ChangeSoldToDatetime < ActiveRecord::Migration
  def up
    remove_column :garments, :sold
    add_column :garments, :sold_at, :datetime
  end

  def down
    add_column :garments, :sold, :boolean
    remove_column :garments, :sold_at
  end
end
