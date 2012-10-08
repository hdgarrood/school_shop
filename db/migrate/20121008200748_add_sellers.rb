class AddSellers < ActiveRecord::Migration
  def change
    create_table :sellers do |t|
      t.column :full_name, :string
      t.column :sons_name, :string
      t.column :email, :string
    end
  end
end
