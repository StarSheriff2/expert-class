require 'rails_helper'
RSpec.describe Course, type: :model do
  it { should have_many(:reservations).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:instructor) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:duration) }
end
