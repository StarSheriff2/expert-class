require 'rails_helper'

RSpec.describe 'API::V1::Sessions', type: :request do
  # initialize test data
  let!(:users) { create_list(:user, 5) }
  let(:existing_username) { { user: { username: users.first.username } } }
  let(:non_existing_username) { { user: { username: 'unexistent_user' } } }

  describe 'POST /api/v1/sign_in' do
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
end

# describe 'POST /todos' do
#   # valid payload
#   let(:valid_attributes) { { title: 'Learn Elm', created_by: '1' } }

#   context 'when the request is valid' do
#     before { post '/todos', params: valid_attributes }

#     it 'creates a todo' do
#       expect(json['title']).to eq('Learn Elm')
#     end

#     it 'returns status code 201' do
#       expect(response).to have_http_status(201)
#     end
#   end

#   context 'when the request is invalid' do
#     before { post '/todos', params: { title: 'Foobar' } }

#     it 'returns status code 422' do
#       expect(response).to have_http_status(422)
#     end

#     it 'returns a validation failure message' do
#       expect(response.body)
#         .to match(/Validation failed: Created by can't be blank/)
#     end
#   end
# end
