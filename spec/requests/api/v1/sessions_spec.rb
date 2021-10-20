require 'rails_helper'

RSpec.describe 'API::V1::Sessions', type: :request do
  describe 'POST /api/v1/sign_in' do
    # initialize test data
    let!(:users) { create_list(:user, 5) }
    let(:existing_username) { { user: { username: users.first.username } } }
    let(:non_existing_username) { { user: { username: 'unexistent_user' } } }

    context 'when the user exists in the database' do
      # make HTTP get request before each example
      before { post '/api/v1/sign_in', params: existing_username }

      it 'returns a json response' do
        expect(json).not_to be_empty
      end

      it 'creates a session variable with user id' do
        expect(session[:user_id]).to eq(users.first.id)
        expect(session[:user_id]).not_to eq(users.second.id)
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
      # make HTTP get request before each example
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
    let!(:user) { create_list(:user, 1) }
    # before { allow(controller).to receive(:@current_user) { user } }

    context 'when there is a session[:user_id] and user exists' do
      # make HTTP get request before each example

      before { get '/api/v1/signed_in' }
      # let(:session_va) { session[users.first.id] }

      it 'returns a json response' do
        p "user: #{user}"
        expect(json).not_to be_empty
        expect(json.size).to be 2
      end

      xit 'creates a session variable with user id' do
        expect(session[:user_id]).to eq(users.first.id)
        expect(session[:user_id]).not_to eq(users.second.id)
      end

      xit 'returns correct user data' do
        expect(json['user']['name']).to eq(users.first.name)
        expect(json['user']['id']).to eq(users.first.id)
        expect(json['user']['id']).not_to eq(users.second.id)
      end

      xit 'returns logged_in status as true' do
        expect(json['logged_in']).to be true
        expect(json['logged_in']).not_to be false
      end

      xit 'returns status code 200' do
        expect(response).to have_http_status(200)
        expect(response).not_to have_http_status(401)
      end

      xit 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the user doesn\'t exist in the database' do
      # make HTTP get request before each example
      before { post '/api/v1/sign_in', params: non_existing_username }

      xit 'returns a json response' do
        expect(json).not_to be_empty
        expect(json.size).to be 1
      end

      xit 'returns status code 401' do
        expect(json['status']).to eq(401)
      end
    end
  end
end

