class AddNameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :full_name, :string, null: false
  end
end
