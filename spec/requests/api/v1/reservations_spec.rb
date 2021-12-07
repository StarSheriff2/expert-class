require 'rails_helper'

RSpec.describe 'API::V1::Reservations', type: :request do

    let!(:courses) { create_list(:course, 5) }
    let!(:reservations) { create_list(:reservation, 5) }

  # user = FactoryGirl.create(:user)
  # @completed_set = FactoryGirl.create(:completed_set, user: user)

  describe 'GET /index' do
    before { get '/api/v1/reservations' }

    it 'returns a message' do
      p "reservations #{reservations}"
      expect(json['message']).to be('Reservation created successfully')
    end

    xit 'returns a list of all reservations' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    xit 'returns http success' do
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /show/:id' do
    before { get "/api/v1/reservations/#{reservations[0].id}" }

    xit 'returns details for one reservations' do
      expect(json).not_to be_empty
    end

    xit 'returns http success' do
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(200)
    end
  end
end
