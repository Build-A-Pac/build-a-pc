class AddDetailsToParts < ActiveRecord::Migration
  def change
    add_column :parts, :details, :text
  end
end
