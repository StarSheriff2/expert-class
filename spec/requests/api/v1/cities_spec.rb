require 'rails_helper'

RSpec.describe 'API::V1::Cities', type: :request do
  let!(:cities) { create_list(:city, 5) }
  let!(:user) { create(:user) }
  let!(:existing_username) { { user: { username: user.username } } }

  describe 'GET /index' do
    context 'when user is signed in' do
      before { post '/api/v1/sign_in', params: existing_username }
      before { get '/api/v1/cities' }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns a list of all cities' do
        expect(json).not_to be_empty
        expect(json.size).to eq(5)
      end
    end
  end
end
