class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :band_id, null: false
      t.string :set, default: "studio"

      t.timestamps null: false
    end
  end
end
