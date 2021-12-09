require 'swagger_helper'

TAGS_COURSE = 'Courses'.freeze

describe 'Courses API' do
  let!(:courses) { create_list(:course, 5) }
  let!(:course_id) { courses.first.id }
  let!(:deleted_course) { courses.first }
  let!(:user) { create(:user) }
  let!(:existing_username) { { user: { username: user.username } } }

  # Stub cloudinary related methods
  image_url = ->(k) { "https://res.cloudinary.com/starsheriff/image/upload/#{k}.jpeg" }
  generate_random_key = -> { Faker::Lorem.characters(number: 10) }

  before do
    allow_any_instance_of(Course).to receive(:attach_image)
    allow_any_instance_of(Course).to receive(:course_image_url) do
      image_url.call(generate_random_key.call)
    end
  end

  before { post '/api/v1/sign_in', params: existing_username }

  after do |example|
    example.metadata[:response][:content] = {
      'application/json' => {
        example: JSON.parse(response.body, symbolize_names: true)
      }
    }
  end

  path '/api/v1/courses' do
    get 'returns list with all courses' do
      tags TAGS_COURSE
      produces 'application/json'

      response '200', 'success' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   description: { type: :string },
                   instructor: { type: :string },
                   duration: { type: :integer },
                   created_at: { type: :string },
                   updated_at: { type: :string },
                   course_image_url: { type: :string }
                 },
                 required: %w[id title description instructor duration created_at updated_at course_image_url]
               },
               required: true
        run_test!
      end
    end
  end

  path '/api/v1/courses/{id}' do
    get 'returns details for one course' do
      tags TAGS_COURSE
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'success' do
        schema type: :object,
        properties: {
          id: { type: :integer },
          title: { type: :string },
          description: { type: :string },
          instructor: { type: :string },
          duration: { type: :integer },
          created_at: { type: :string },
          updated_at: { type: :string },
          course_image_url: { type: :string }
        },
        required: %w[id title description instructor duration created_at updated_at course_image_url]

        let(:id) { course_id }
        run_test!
      end
    end
  end
end


