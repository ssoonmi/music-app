class Note < ApplicationRecord
  validates :body, presence: true

  belongs_to :user,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :track,
    foreign_key: :track_id,
    class_name: :Track
end
