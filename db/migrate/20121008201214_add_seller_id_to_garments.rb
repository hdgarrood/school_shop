class AddSellerIdToGarments < ActiveRecord::Migration
  def change
    alter_table :garments do |t|
      t.references :seller
    end

    add_index :garments, :seller_id
  end
end
