class AddAlbumsInfoColumnsAndIndices < ActiveRecord::Migration
  def change
    add_column :albums, :year, null: false
    add_index :albums, [:band_id, :name]
  end
end
