class CreateGarmentDescriptions < ActiveRecord::Migration
  def up
    create_table :garment_descriptions do |t|
      t.string :description
    end
  end

  def down
    drop_table :garment_descriptions
  end
end
