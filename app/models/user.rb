class User < ApplicationRecord
  validates :username, presence: true, length: { minimum: 12, maximum: 20 }, uniqueness: true
  validates :name, presence: true, length: { maximum: 24 }

  has_many :reservations, dependent: :destroy
end
