require 'rails_helper'

RSpec.describe 'API::V1::Courses', type: :request do
  let!(:courses) { create_list(:course, 5) }
  let(:course_id) { courses.first.id }

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
    let(:valid_attributes) do
      {
        course: {
          title: 'Web Development',
          description: 'Learn to build websites.',
          instructor: 'Mike',
          duration: 12,
          image: ''
        }
      }
    end

    context 'when the request is valid' do
      before { post '/api/v1/courses', params: valid_attributes }

      it 'creates a course' do
        expect(response.body)
          .to match(/Course successfully created/)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/courses', params: { course: { title: 'Incomplete Course' } } }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Unable to create course/)
      end
    end
  end

  describe 'DELETE /api/v1/courses/:id' do
    before { delete "/api/v1/courses/#{course_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
