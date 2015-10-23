class AddActivationForUser < ActiveRecord::Migration
  def change
    remove_column :users, :counter
    add_column :users, :activated, :boolean, default: false
    add_column :users, :activation_token, :string, null: false

    add_index :users, :activation_token

  end
end
