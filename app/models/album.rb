# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  band_id    :integer          not null
#  set        :string           default("studio")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ActiveRecord::Base
  ALBUM_SETS = ["live", "studio"]

  belongs_to :band
  has_many :tracks, dependent: :destroy

  validates(
    :band,
    :year,
    :title,
    :band_id,
    :set,
    presence: true)

  validates :set, inclusion: ALBUM_SETS
  validates :name, uniqueness: { scope: :band_id }
  validates :year, numericality: { minimum: 1000 } 


end
