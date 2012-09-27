class CreateGarments < ActiveRecord::Migration
  def change
    create_table :garments do |t|
      t.references :garment_description
      t.boolean :sold

      t.timestamps
    end

    add_index :garments, :garment_description_id
  end
end
