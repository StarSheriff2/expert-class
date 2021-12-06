require 'rails_helper'

RSpec.describe 'API::V1::Courses', type: :request do
  let!(:courses) { create_list(:course, 5) }
  let(:course_id) { courses.first.id }
  let!(:users) { create_list(:user, 5) }
  let(:existing_username) { { user: { username: users.first.username } } }

  before { post '/api/v1/sign_in', params: existing_username }

  describe 'GET /api/v1/courses' do
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

  describe 'GET /api/v1/courses/:id' do
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
        jsonParsed = JSON.parse(response.body)
        expect(jsonParsed['status']).to eq('created')
      end

      it 'returns created course in json response' do
        jsonParsed = JSON.parse(response.body)
        course = JSON.parse(
          {
            title: 'Web Development',
            description: 'Learn to build websites.',
            instructor: 'Mike',
            duration: 12,
            course_image_url: image_url
          }.to_json
        )

        expect(jsonParsed['course']).to include(course)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/courses', params: invalid_attributes }

      it 'returns a message' do
        jsonParsed = JSON.parse(response.body)
        expect(jsonParsed['message']).to eq('Unable to create course')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns a json body to contain status 400' do
        jsonParsed = JSON.parse(response.body)
        expect(jsonParsed['status']).to eq(400)
      end
    end
  end

  describe 'DELETE /api/v1/courses/:id' do
    before { delete "/api/v1/courses/#{course_id}" }

    xit 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
