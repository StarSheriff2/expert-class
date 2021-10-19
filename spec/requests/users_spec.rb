require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  # initialize test data
  let!(:users) { create_list(:user, 10) }
  let(:user_id) { users.first.id }

  # Test suite for GET /users
  describe 'GET /api/v1/users' do
    # make HTTP get request before each example
    before { get '/api/v1/users' }

    it 'returns users' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for POST /users
  describe 'POST /api/v1/users' do
    # valid payload
    let(:valid_attributes) { { name: 'Mih Julius', username: 'Julius' } }

    context 'when the request is valid' do
      before { post '/api/v1/users', params: valid_attributes }

      it 'creates a user' do
        expect(json['name']).to eq('Mih Julius')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/users', params: { name: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to include("Username is too short (minimum is 6 characters")
      end
    end
  end

  # Test suite for DELETE /users/:id
  describe 'DELETE /api/v1/users/:id' do
    before { delete "/api/v1/users/#{user_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end