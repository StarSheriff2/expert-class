class Course < ApplicationRecord
  validates :title, presence: true, length: { maximum: 48 }
  validates :description, presence: true, length: { maximum: 1200, too_long: 'Too long. Maximum is 1200 characters.' }
  validates :instructor, presence: true, length: { maximum: 48 }
  validates :duration, presence: true, length: { maximum: 12 }

  has_many :reservations, dependent: :destroy
end
