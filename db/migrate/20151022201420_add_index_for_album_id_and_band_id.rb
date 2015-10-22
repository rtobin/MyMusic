class AddIndexForAlbumIdAndBandId < ActiveRecord::Migration
  def change
    add_index :albums, :band_id, unique: true
    add_index :tracks, :album_id, unique: true
  end
end
