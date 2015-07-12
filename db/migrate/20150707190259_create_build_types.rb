class CreateBuildTypes < ActiveRecord::Migration
  def change
    create_table :build_types do |t|
      t.string :name
      t.integer :cpu_weight
      t.integer :gpu_weight
      t.integer :psu_weight
      t.integer :ram_weight
      t.integer :storage_weight

      t.timestamps null: false
    end
  end
end
