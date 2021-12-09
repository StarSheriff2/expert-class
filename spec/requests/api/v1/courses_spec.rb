require 'rails_helper'

RSpec.describe 'API::V1::Courses', type: :request do
  let!(:courses) { create_list(:course, 5) }
  let!(:course_id) { courses.first.id }
  let!(:deleted_course) { courses.first }
  let!(:users) { create_list(:user, 5) }
  let!(:existing_username) { { user: { username: users.first.username } } }

  describe 'GET /api/v1/courses' do
    context 'when a user is signed in' do
      before { post '/api/v1/sign_in', params: existing_username }
      before { get '/api/v1/courses' }

      it 'returns a list of all courses' do
        expect(json).not_to be_empty
        expect(json.size).to eq(5)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
        expect(response).to have_http_status(200)
      end
    end

    context 'when there is no user signed in' do
      before { get '/api/v1/courses' }

      it 'returns http bad request of 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns error message' do
        expect(json['error']).to eq('You are not logged in. Please log in first.')
      end
    end
  end

  describe 'GET /api/v1/courses/:id' do
    before { post '/api/v1/sign_in', params: existing_username }
    before { get "/api/v1/courses/#{course_id}" }

    context 'when the record exists' do
      it 'returns details for one course' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(course_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the record does not exist' do
      let(:course_id) { 999 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Course/)
      end
    end
  end

  describe 'POST /api/v1/courses' do
    # Setup stubs and mocks
    let(:file) { Rack::Test::UploadedFile.new('spec/test_images/instructor1.jpeg', 'image/jpeg') }
    let(:image_url) { 'https://res.cloudinary.com/starsheriff/image/upload/9p1zegof9agndzl0kjhvgpztof20.jpeg' }

    let(:valid_attributes) do
      {
        course: {
          title: 'Web Development',
          description: 'Learn to build websites.',
          instructor: 'Mike',
          duration: 12,
          image: file
        }
      }
    end

    let(:invalid_attributes) do
      {
        course: {
          title: 'Web Development',
          description: 'Learn to build websites.',
          duration: 12,
          image: file
        }
      }
    end

    # Stub cloudinary related methods
    before do
      allow_any_instance_of(Course).to receive(:attach_image)
      allow_any_instance_of(Course).to receive(:course_image_url).and_return(image_url)
    end

    before { post '/api/v1/sign_in', params: existing_username }

    context 'when the request is valid' do
      before { post '/api/v1/courses', params: valid_attributes }

      it 'creates a course' do
        expect(response.body)
          .to match(/Course successfully created/)
      end

      it 'returns a json response of size 3' do
        expect(json).not_to be_empty
        expect(json.size).to eq(3)
      end

      it 'returns a json body to contain message \'created\'' do
        expect(json['status']).to eq('created')
      end

      it 'returns created course in json response' do
        course = JSON.parse(
          {
            title: 'Web Development',
            description: 'Learn to build websites.',
            instructor: 'Mike',
            duration: 12,
            course_image_url: image_url
          }.to_json
        )

        expect(json['course']).to include(course)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/courses', params: invalid_attributes }

      it 'returns a message' do
        expect(json['message']).to eq('Unable to create course')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns a status 400 within json body' do
        expect(json['status']).to eq(400)
      end
    end
  end

  describe 'DELETE /api/v1/courses/:id' do
    before { post '/api/v1/sign_in', params: existing_username }

    context 'when course exists in db' do
      before { delete "/api/v1/courses/#{course_id}" }

      it 'returns deleted course in response body' do
        id = { 'id' => deleted_course.id }
        description = { 'description' => deleted_course.description }
        expect(json['course']).to include(id)
        expect(json['course']).to include(description)
      end

      it 'returns a message' do
        expect(json['message']).to eq('Course successfully deleted')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns status code 200' do
        expect(json['status']).to be(200)
      end
    end

    context 'when course doesn\'t exist in db' do
      before { delete "/api/v1/courses/#{course_id}" }
      before { delete "/api/v1/courses/#{course_id}" }

      it 'returns a message' do
        expect(json['message']).to eq("Couldn't find Course with 'id'=#{course_id}")
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
