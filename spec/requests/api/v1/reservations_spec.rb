require 'rails_helper'

RSpec.describe 'API::V1::Reservations', type: :request do
  let!(:users) { create_list(:user, 5) }
  let!(:existing_username) { { user: { username: users.first.username } } }
  let!(:reservations) { create_list(:reservation, 5, user: users.first) }

  # user = FactoryGirl.create(:user)
  # @completed_set = FactoryGirl.create(:completed_set, user: user)

  describe 'GET /index' do
    context 'when user is signed in' do
      before { post '/api/v1/sign_in', params: existing_username }
      before { get '/api/v1/reservations' }

      it 'returns a list of all reservations' do
        # p "reservations: #{reservations}"
        expect(json).not_to be_empty
        expect(json.size).to eq(5)
      end

      it 'returns a list of all reservations with name of logged in user' do
        name_query_logged_user = json.all? { |r| r['user'] == users.first.name }
        name_query_logged_out_user = json.all? { |r| r['user'] == users.second.name }
        expect(name_query_logged_user).to be true
        expect(name_query_logged_out_user).to be false
      end

      it 'returns http success' do
        expect(response).to have_http_status(:ok)
        expect(response).to have_http_status(:success)
        expect(response).to have_http_status(200)
      end
    end

    context 'when user is not signed in' do
      before { get '/api/v1/reservations' }

      it 'returns http bad request of 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns error message' do
        expect(json['error']).to eq('You are not logged in. Please log in first.')
      end
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
