class Reservation < ApplicationRecord
  validates :date, presence: true
  validates :user_id, presence: true
  validates :course_id, presence: true
  validates :city_id, presence: true

  belongs_to :user
  belongs_to :course
  belongs_to :city
end
