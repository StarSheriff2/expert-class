require 'swagger_helper'

TAGS_USER = 'Users'.freeze

describe 'Users API' do
  let!(:users) { create_list(:user, 3) }

  user_params = JSON.parse({
    user:
      {
        name: Faker::Name.first_name,
        username: Faker::Lorem.characters(number: 10)
      }
  }.to_json)

  let!(:valid_new_user_params) do
    { user:
      {
        name: user_params['user']['name'],
        username: user_params['user']['username']
      } }
  end

  let!(:invalid_new_user_params) do
    { user:
      {
        name: users.first['name'],
        username: users.first['username']
      } }
  end

  after do |example|
    example.metadata[:response][:content] = {
      'application/json' => {
        examples: {
          example.metadata[:example_group][:description] => {
            value: JSON.parse(response.body, symbolize_names: true)
          }
        }
      }
    }
  end

  path '/api/v1/users' do
    post 'creates a new user' do
      tags TAGS_USER
      produces 'application/json'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          username: { type: :string }
        },
        required: %w[name username]
      },
                required: true

      response '200', 'success' do
        context 'when user exists' do
          schema type: :object
          let(:user) { valid_new_user_params }
          run_test!
        end

        context 'when user does not exist' do
          schema type: :object
          let(:user) { invalid_new_user_params }
          run_test!
        end
      end
    end
  end
end
