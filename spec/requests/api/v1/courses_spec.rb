require 'rails_helper'

RSpec.describe 'API::V1::Courses', type: :request do
  let!(:courses) { create_list(:course, 5) }

  describe 'GET /index' do
    before { get '/api/v1/courses' }

    it 'returns a list of all users' do
      expect(json).not_to be_empty
      expect(json.size).to be >= 4
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(200)
    end
  end
end
