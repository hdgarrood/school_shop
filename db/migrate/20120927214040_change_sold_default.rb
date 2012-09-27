class ChangeSoldDefault < ActiveRecord::Migration
  def change
    change_column_default(:garments, :sold, false)
  end
end
