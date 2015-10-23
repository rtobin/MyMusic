class RemoveIndicesFromAlbumIdAndBandId < ActiveRecord::Migration
  def change
    remove_index(:albums, column: :band_id)
    remove_index(:tracks, column: :album_id)
  end
end
