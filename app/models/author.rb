class Author < ApplicationRecord
  belongs_to :user
  belongs_to :music
  has_one :image_cover_blob, through: :music
  has_one :music_blob, through: :music
end
