class CreateComputerParts < ActiveRecord::Migration
  def change
    create_table :computer_parts do |t|
      t.integer :computer_id
      t.integer :part_id

      t.timestamps null: false
    end
  end
end
