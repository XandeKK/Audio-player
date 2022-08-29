class Music < ApplicationRecord
  has_many :authors, dependent: :destroy
  
  has_one_attached :music
  has_one_attached :image_cover

  validates :title, presence: true
  validates :music, attached: true, size: { less_than: 500.megabytes , message: 'is too large' }
  validates :image_cover, attached: true, size: { less_than: 10.megabytes , message: 'is too large' }
end
