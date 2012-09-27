class CreateGarmentDescriptions < ActiveRecord::Migration
  def change
    create_table :garment_descriptions do |t|
      t.string :description
    end
  end
end
