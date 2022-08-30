class User < ApplicationRecord
  include Clearance::User
  has_many :authors, dependent: :destroy

  validates :name, presence: true
end
