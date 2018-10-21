# == Schema Information
#
# Table name: albums
#
#  id         :bigint(8)        not null, primary key
#  band_id    :integer          not null
#  title      :string           not null
#  year       :integer
#  is_live    :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ApplicationRecord
  validates :title, presence: true

  after_initialize :ensure_is_live

  def ensure_is_live
    self.is_live = false if self.is_live.nil?
  end

  belongs_to :band,
    foreign_key: :band_id,
    class_name: :Band

  has_many :tracks,
    foreign_key: :album_id,
    class_name: :Track,
    dependent: :destroy
end
