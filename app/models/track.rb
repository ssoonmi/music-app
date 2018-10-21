# == Schema Information
#
# Table name: tracks
#
#  id         :bigint(8)        not null, primary key
#  album_id   :integer          not null
#  title      :string           not null
#  ord        :integer
#  lyrics     :text
#  is_bonus   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ApplicationRecord
  validates :title, presence: true

  after_initialize :ensure_is_bonus

  def ensure_is_bonus
    self.is_bonus = false if self.is_bonus.nil?
  end

  belongs_to :album,
    foreign_key: :album_id,
    class_name: :Album

  has_one :band,
    through: :album,
    source: :band

  has_many :notes,
    foreign_key: :track_id,
    class_name: :Note,
    dependent: :destroy

  def sibling_tracks
    album.tracks.where.not(id: self.id)
  end

end
