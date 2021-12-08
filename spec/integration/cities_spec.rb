require 'swagger_helper'

describe 'Cities API' do
  let!(:user) { create(:user) }
  let!(:existing_username) { { user: { username: user.username } } }

  before { post '/api/v1/sign_in', params: existing_username }

  path '/api/v1/cities' do
    get 'returns a list of all cities' do
      tags 'Cities'
      produces 'application/json'

      response '200', 'success' do
        schema type: :array, items: {
          type: :object
        }
        examples 'application/json' => [
          {
            id: 1,
            name: Faker::Nation.capital_city
          },
          {
            id: 2,
            name: Faker::Nation.capital_city
          }
        ]

        run_test!
      end
    end
  end
end
