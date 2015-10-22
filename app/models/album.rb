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

  belongs_to :band

  has_many :tracks, dependent: :destroy
end
