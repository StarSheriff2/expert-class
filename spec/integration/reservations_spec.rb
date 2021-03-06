require 'swagger_helper'

TAGS_RESERVATION = 'Reservations'.freeze

describe 'Reservations API' do
  let!(:users) { create_list(:user, 5) }
  let!(:existing_username) { { user: { username: users.first.username } } }
  let!(:reservations) { create_list(:reservation, 5, user: users.first) }
  let!(:deleted_reservation) { reservations.last }
  let!(:courses) { create_list(:course, 10) }
  let!(:cities) { create_list(:city, 5) }
  let(:valid_attributes) do
    {
      reservation: {
        date: Date.tomorrow,
        user_id: users.first.id,
        course_id: courses.second.id,
        city_id: cities.third.id
      }
    }
  end

  before { post '/api/v1/sign_in', params: existing_username }

  after do |example|
    example.metadata[:response][:content] = {
      'application/json' => {
        example: JSON.parse(response.body, symbolize_names: true)
      }
    }
  end

  path '/api/v1/reservations' do
    get 'returns list with all reservations' do
      tags TAGS_RESERVATION
      produces 'application/json'

      response '200', 'success' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   user: { type: :string },
                   course: { type: :string },
                   city: { type: :string },
                   date: { type: :string },
                   id: { type: :integer },
                   created_at: { type: :string },
                   updated_at: { type: :string }
                 },
                 required: %w[user course city date id created_at updated_at]
               },
               required: true

        run_test!
      end
    end
  end

  # rubocop:disable Metrics/BlockLength
  path '/api/v1/reservations' do
    post 'creates a new course' do
      tags TAGS_RESERVATION
      produces 'application/json'
      consumes 'application/json'
      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          date: { type: :string },
          user_id: { type: :integer },
          course_id: { type: :integer },
          city_id: { type: :integer }
        },
        required: %w[date user_id course_id city_id]
      },
                required: true

      response '200', 'success' do
        schema type: :object,
               properties: {
                 reservation: {
                   type: :object,
                   properties: {
                     user: { type: :string },
                     course: { type: :string },
                     city: { type: :string },
                     date: { type: :string },
                     id: { type: :integer },
                     created_at: { type: :string },
                     updated_at: { type: :string }
                   },
                   required: %w[user course city date id created_at updated_at]
                 },
                 message: { type: :string },
                 status: { type: :integer }
               },
               required: %w[reservation message status]

        let(:reservation) { valid_attributes }
        run_test!
      end
    end
  end

  path '/api/v1/reservations/{id}' do
    delete 'deletes a reservation' do
      tags TAGS_RESERVATION
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'success' do
        schema type: :object,
               properties: {
                 reservation: {
                   type: :object,
                   properties: {
                     user_id: { type: :integer },
                     course_id: { type: :integer },
                     city_id: { type: :integer },
                     date: { type: :string },
                     id: { type: :integer },
                     created_at: { type: :string },
                     updated_at: { type: :string }
                   },
                   required: %w[user_id course_id city_id date id created_at updated_at]
                 },
                 message: { type: :string }
               },
               required: %w[reservation message]

        let!(:id) { deleted_reservation.id }
        run_test!
      end

      response '404', 'success' do
        schema type: :object,
               properties: {
                 message: { type: :string }
               },
               required: %w[message]

        let!(:id) { deleted_reservation.id + 1000 }
        run_test!
      end
    end
  end
  # rubocop:enable Metrics/BlockLength
end
