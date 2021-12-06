require 'rails_helper'

RSpec.describe 'API::V1::Sessions', type: :request do
  describe 'POST /api/v1/sign_in' do
    # initialize test data
    let!(:users) { create_list(:user, 5) }
    let(:existing_username) { { user: { username: users.first.username } } }
    let(:non_existing_username) { { user: { username: 'unexistent_user' } } }

    context 'when the user exists in the database' do
      # make HTTP post request before each example
      before { post '/api/v1/sign_in', params: existing_username }

      it 'returns a json response' do
        expect(json).not_to be_empty
      end

      it 'creates a session variable with user id' do
        expect(session[:user_id]).to eq(users.first.id)
        expect(session[:user_id]).not_to eq(users.second.id)
        expect(session[:user_id]).not_to eq(users.last.id)
      end

      it 'returns correct user data' do
        expect(json['user']['name']).to eq(users.first.name)
        expect(json['user']['id']).to eq(users.first.id)
        expect(json['user']['id']).not_to eq(users.second.id)
      end

      it 'returns logged_in status as true' do
        expect(json['logged_in']).to be true
        expect(json['logged_in']).not_to be false
      end

      it 'returns json status as \'created\'' do
        expect(json['status']).to eq('created')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
        expect(response).not_to have_http_status(401)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the user doesn\'t exist in the database' do
      # make HTTP post request before each example
      before { post '/api/v1/sign_in', params: non_existing_username }

      it 'returns a json response' do
        expect(json).not_to be_empty
        expect(json.size).to be 1
      end

      it 'returns status code 401' do
        expect(json['status']).to eq(401)
      end
    end
  end

  describe 'GET /api/v1/signed_in' do
    # initialize test data
    let!(:users) { create_list(:user, 5) }

    context 'when there is a session[:user_id] and user exists' do
      # make HTTP login request before each example
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session) { { user_id: users.second.id } }
        get '/api/v1/signed_in'
      end

      it 'returns a json response' do
        expect(json).not_to be_empty
        expect(json.size).to be 2
      end

      it 'reads session variable with correct user id' do
        expect(session[:user_id]).to eq(users.second.id)
        expect(session[:user_id]).not_to eq(users.last.id)
      end

      it 'returns correct user data' do
        expect(json['user']['name']).to eq(users.second.name)
        expect(json['user']['id']).to eq(users.second.id)
        expect(json['user']['username']).to eq(users.second.username)
        expect(json['user']['id']).not_to eq(users.first.id)
      end

      it 'returns logged_in status as true' do
        expect(json['logged_in']).to be true
        expect(json['logged_in']).not_to be false
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when there is no session[:user_id]' do
      # make HTTP get request before each example
      before { get '/api/v1/signed_in' }

      it 'returns a json response' do
        expect(json).not_to be_empty
        expect(json.size).to be 1
      end

      it 'returns logged_in status as false' do
        expect(json['logged_in']).to be false
        expect(json['logged_in']).not_to be true
      end
    end
  end

  describe 'DELETE /api/v1/sign_out' do
    let!(:users) { create_list(:user, 5) }
    let(:existing_username) { { user: { username: users.first.username } } }

    before { post '/api/v1/sign_in', params: existing_username }
    before { delete '/api/v1/sign_out' }

    it 'returns a json response' do
      expect(json).not_to be_empty
      expect(json.size).to be 2
    end

    it 'resets session variable' do
      expect(session[:user_id]).to be_nil
    end

    it 'returns logged_out status as false' do
      expect(json['logged_out']).to be true
      expect(json['logged_out']).not_to be false
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
      expect(response).not_to have_http_status(401)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
