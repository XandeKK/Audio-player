class Category < ApplicationRecord
  has_many :music_categories, dependent: :destroy
  validates :name, presence: true
end
