class Reservation < ApplicationRecord
  validates :date, presence: true
  validates :city, presence: true

  belongs_to :user
  belongs_to :course
end
