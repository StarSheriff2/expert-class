require 'rails_helper'

RSpec.describe 'API::V1::Users', type: :request do
  let!(:users) { create_list(:user, 3) }
  let(:user_id) { users.second.id }

  user_params = JSON.parse({
    user:
      {
        name: Faker::Name.first_name,
        username: Faker::Lorem.characters(number: 10)
      }
    }.to_json
  )

  let!(:valid_new_user_params) {
    { user:
      {
        name: user_params['user']['name'],
        username: user_params['user']['username']
      }
    }
  }

  let!(:invalid_new_user_params) {
    { user:
      {
        name: users.first['name'],
        username: users.first['username']
      }
    }
  }

  describe 'POST /api/v1/users' do

    context 'valid params' do
      before { post '/api/v1/users', params: valid_new_user_params }

      it 'returns json response' do
        expect(json).not_to be_empty
        expect(json.size).to be 3
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
        expect(response).to have_http_status(200)
      end

      it 'returns a status message of created' do
        expect(json['status']).to eq('created')
      end

      it 'returns logged_in status as true' do
        expect(json['logged_in']).to eq(true)
      end

      it 'returns the new user data in the response' do
        expect(json['user']).to include(user_params['user'])
      end
    end

    context 'invalid params' do
      before { post '/api/v1/users', params: invalid_new_user_params }

      it 'returns json response' do
        expect(json).not_to be_empty
        expect(json.size).to be 2
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
        expect(response).to have_http_status(200)
      end

      it 'returns an error message' do
        expect(json['error']).to eq('This username already exists. Please Choose another one.')
      end

      it 'returns a status number of 401' do
        expect(json['status']).to eq(401)
      end
    end

  end
end
