class User < ApplicationRecord
  include Clearance::User
  has_many :authors, dependent: :destroy
end
