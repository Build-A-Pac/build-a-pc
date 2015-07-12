class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :name
      t.string :make
      t.string :model
      t.string :category
      t.float :cost
      t.string :store_url

      t.timestamps null: false
    end
  end
end
