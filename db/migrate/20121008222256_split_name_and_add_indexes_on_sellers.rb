class SplitNameAndAddIndexesOnSellers < ActiveRecord::Migration
  def change
    remove_column :sellers, :full_name

    change_table :sellers do |t|
      t.column :first_name, :string
      t.index :first_name
      t.column :surname, :string
      t.index :surname
    end
  end
end
