# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  album_id   :integer          not null
#  bonus      :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ActiveRecord::Base

  belongs_to :album

  has_one :band,
    through: :album,
    source: :band

  has_many :notes, dependent: :destroy

  validates(
    :album,
    :title,
    :ord,
    presence: :true
  )

  validates :bonus, inclusion: { in: [true, false] }
  validates :ord, uniqueness: { scope: :album_id }

end
