class User < ApplicationRecord
  validates :username, presence: true, length: { minimum: 6, maximum: 12 }
  validates :name, presence: true, length: { maximum: 24 }

  has_many :reservations
end
