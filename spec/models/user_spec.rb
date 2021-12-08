require 'rails_helper'

# Test suite for the Todo model
RSpec.describe User, type: :model do
  # Association test
  it { should have_many(:reservations).dependent(:destroy) }
  # Validation tests
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:name) }
end
