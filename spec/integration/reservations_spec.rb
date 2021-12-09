require 'swagger_helper'

TAGS_RESERVATION = 'Reservations'.freeze

describe 'Reservations API' do
  let!(:users) { create_list(:user, 5) }
  let!(:existing_username) { { user: { username: users.first.username } } }
  let!(:reservations) { create_list(:reservation, 5, user: users.first) }
  let!(:deleted_reservation) { reservations.last }
  let!(:courses) { create_list(:course, 10) }
  let!(:cities) { create_list(:city, 5) }

  # Stub cloudinary related methods
  # image_url = ->(k) { "https://res.cloudinary.com/starsheriff/image/upload/#{k}.jpeg" }
  # generate_random_key = -> { Faker::Lorem.characters(number: 10) }

  # before do
  #   allow_any_instance_of(Course).to receive(:attach_image)
  #   allow_any_instance_of(Course).to receive(:course_image_url) do
  #     image_url.call(generate_random_key.call)
  #   end
  # end

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
                   user: { type: :string},
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

  # path '/api/v1/courses' do
  #   post 'creates a new course' do
  #     tags TAGS_COURSE
  #     produces 'application/json'
  #     consumes 'multipart/form-data'
  #     parameter name: 'course',
  #               in: :formData,
  #               schema: {
  #                 type: :object,
  #                 properties: {
  #                   title: { type: :string },
  #                   description: { type: :string },
  #                   instructor: { type: :string },
  #                   duration: { type: :integer },
  #                   image: { type: :binary }
  #                 },
  #                 required: %w[title description instructor duration image]
  #               },
  #               required: %w[course]

  #     response '200', 'success' do
  #       schema type: :object,
  #              properties: {
  #                course: { type: :object },
  #                message: { type: :string },
  #                status: { type: :string }
  #              },
  #              required: %w[course message status]

  #       let(:course) { valid_attributes }
  #       run_test!
  #     end
  #   end
  # end

  # path '/api/v1/courses/{id}' do
  #   delete 'deletes a course' do
  #     tags TAGS_COURSE
  #     produces 'application/json'
  #     parameter name: :id, in: :path, type: :string

  #     response '200', 'success' do
  #       schema type: :object,
  #              properties: {
  #                course: { type: :object },
  #                message: { type: :string },
  #                status: { type: :integer }
  #              },
  #              required: %w[course message status]

  #       before { allow_any_instance_of(Course).to receive(:destroy) }
  #       let!(:id) { course_id }
  #       run_test!
  #     end

  #     response '404', 'success' do
  #       schema type: :object,
  #              properties: {
  #                message: { type: :string }
  #              },
  #              required: %w[message]

  #       let!(:id) { course_id + 1000 }
  #       run_test!
  #     end
  #   end
  # end
end
