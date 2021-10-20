require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:course) }
  it { should belong_to(:city) }

  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:course_id) }
  it { should validate_presence_of(:city_id) }
end
