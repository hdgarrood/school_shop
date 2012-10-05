class AddPriceToGarments < ActiveRecord::Migration
  def change
    add_column :garments, :price, :decimal, :precision => 16, :scale => 2
  end
end
