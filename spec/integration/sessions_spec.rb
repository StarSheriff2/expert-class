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

describe 'Sessions API' do
  let!(:users) { create_list(:user, 5) }
  let(:existing_username) { { user: { username: users.first.username } } }

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

  path '/api/v1/signed_in' do
    get 'return login status of user' do
      tags TAGS_SESSION
      produces 'application/json'

      response '200', 'success' do
        context 'when user is logged in' do
          before { post '/api/v1/sign_in', params: existing_username }
          schema type: :object,
                 properties: {
                   logged_in: { type: :boolean },
                   user: { type: :object }
                 },
                 required: %w[logged_in]
          run_test!
        end

        context 'when user is not logged in' do
          schema type: :object,
                 properties: {
                   logged_in: { type: :boolean }
                 },
                 required: %w[logged_in]
          run_test!
        end
      end
    end
  end
end

describe 'Sessions API' do
  let!(:users) { create_list(:user, 5) }
  let(:existing_username) { { user: { username: users.first.username } } }

  before { post '/api/v1/sign_in', params: existing_username }

  after do |example|
    example.metadata[:response][:content] = {
      'application/json' => {
        example: JSON.parse(response.body, symbolize_names: true)
      }
    }
  end

  path '/api/v1/sign_out' do
    delete 'return logged-out status of user as true' do
      tags TAGS_SESSION
      produces 'application/json'

      response '200', 'success' do
        schema type: :object,
               properties: {
                 status: { type: :integer },
                 logged_out: { type: :boolean }
               },
               required: %w[status logged_out]
        run_test!
      end
    end
  end
end
