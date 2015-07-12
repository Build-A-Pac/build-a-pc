class CreateComputers < ActiveRecord::Migration
  def change
    create_table :computers do |t|
      t.integer :user_id
      t.string :computer_name

      t.timestamps null: false
    end
  end
end
