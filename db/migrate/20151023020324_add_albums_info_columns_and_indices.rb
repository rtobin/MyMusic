class AddAlbumsInfoColumnsAndIndices < ActiveRecord::Migration
  def change
    add_column :albums, :year, :integer, null: false
    add_index :albums, [:band_id, :title]
  end
end
