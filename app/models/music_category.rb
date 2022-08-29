class MusicCategory < ApplicationRecord
  belongs_to :music
  belongs_to :category
end
