require 'swagger_helper'

TAGS_CITY = 'Cities'.freeze

describe 'Cities API' do
  let!(:user) { create(:user) }
  let!(:existing_username) { { user: { username: user.username } } }

  after do |example|
    example.metadata[:response][:content] = {
      'application/json' => {
        example: JSON.parse(response.body, symbolize_names: true)
      }
    }
  end

  before { post '/api/v1/sign_in', params: existing_username }

  path '/api/v1/cities' do
    get 'returns a list of all cities' do
      tags TAGS_CITY
      produces 'application/json'

      response '200', 'success' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string }
                 },
                 required: %w[id name created_at updated_at]
               }

        let!(:cities) { create_list(:city, 5) }

        run_test!
      end
    end
  end
end
