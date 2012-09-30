class MakeNameUnique < ActiveRecord::Migration
  def change
    add_index :garment_types, [:name], :unique => true
  end
end
