class AddTrackOrdAndLyrics < ActiveRecord::Migration
  def change
    add_column :tracks, :ord, :integer, null: false
    add_column :tracks, :lyrics, :text

    add_index :tracks, [:album_id, :ord]
  end
end
