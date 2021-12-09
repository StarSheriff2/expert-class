require 'swagger_helper'

TAGS_SESSION = 'Sessions'.freeze

describe 'Sessions API' do
  let!(:users) { create_list(:user, 5) }
  let(:existing_username) { { user: { username: users.first.username } } }
  let(:non_existing_username) { { user: { username: 'unexistent_user' } } }

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

  path '/api/v1/sign_in' do
    post 'creates a new session' do
      tags TAGS_SESSION
      produces 'application/json'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string }
        },
        required: %w[username]
      }

      response '200', 'success' do
        context 'when user exists' do
          schema type: :object
          let(:user) { existing_username }
          run_test!
        end

        context 'when user does not exist' do
          schema type: :object
          let(:user) { non_existing_username }
          run_test!
        end
      end
    end
  end
end
