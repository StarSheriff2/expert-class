require 'rails_helper'

RSpec.describe 'API::V1::Reservations', type: :request do
  let!(:reservations) { create_list(:reservation, 5) }

  describe 'GET /index' do
    before { get '/api/v1/reservations' }

    it 'returns a list of all courses' do
      expect(json).not_to be_empty
      expect(json.size).to be >= 4
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /show/:id' do
    before { get "/api/v1/reservations/#{reservations[0].id}" }

    it 'returns details for one course' do
      expect(json).not_to be_empty
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(200)
    end
  end
end
