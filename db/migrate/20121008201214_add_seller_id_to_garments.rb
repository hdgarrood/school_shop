class AddSellerIdToGarments < ActiveRecord::Migration
  def change
    change_table :garments do |t|
      t.references :seller
    end

    add_index :garments, :seller_id
  end
end
