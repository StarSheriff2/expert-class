require 'rails_helper'

RSpec.describe 'API::V1::Cities', type: :request do
  describe 'GET /index' do
    before { get '/api/v1/cities' }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
