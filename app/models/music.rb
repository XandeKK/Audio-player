class Music < ApplicationRecord
  has_many :music_categories, dependent: :destroy
  has_many :authors, dependent: :destroy

  accepts_nested_attributes_for :authors, :music_categories
  
  has_one_attached :music
  has_one_attached :image_cover

  validates :title, presence: true
  validates :music, attached: true,
    content_type: /\Aaudio\/.*\z/,
    size: { less_than: 500.megabytes , message: 'is too large' }
  validates :image_cover, attached: true,
    content_type: /\Aimage\/.*\z/,
    size: { less_than: 10.megabytes , message: 'is too large' }
end
