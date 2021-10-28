class Course < ApplicationRecord
  include Rails.application.routes.url_helpers

  validates :title, presence: true, length: { maximum: 48 }
  validates :description, presence: true, length: { maximum: 1200, too_long: 'Too long. Maximum is 1200 characters.' }
  validates :instructor, presence: true, length: { maximum: 48 }
  validates :duration, presence: true, length: { maximum: 12 }
  validates :image, {
    presence: true
  }

  has_many :reservations, dependent: :destroy

  has_one_attached :image, dependent: :destroy

  def attach_image
    self.course_image_url = image.url if image.attached?
  end
end
