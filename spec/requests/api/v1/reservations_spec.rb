require 'rails_helper'

RSpec.describe 'API::V1::Reservations', type: :request do
  let!(:users) { create_list(:user, 5) }
  let!(:existing_username) { { user: { username: users.first.username } } }
  let!(:reservations) { create_list(:reservation, 5, user: users.first) }
  let!(:deleted_reservation) { reservations.last }
  let!(:courses) { create_list(:course, 10) }
  let!(:cities) { create_list(:city, 5) }

  describe 'GET /index' do
    context 'when user is signed in' do
      before { post '/api/v1/sign_in', params: existing_username }
      before { get '/api/v1/reservations' }

      it 'returns a list of all reservations' do
        expect(json).not_to be_empty
        expect(json.size).to eq(5)
      end

      it 'returns a list of all reservations with name of logged in user' do
        name_query_logged_user = json.all? { |r| r['user'] == users.first.name }
        name_query_logged_out_user = json.all? { |r| r['user'] == users.second.name }
        expect(name_query_logged_user).to be true
        expect(name_query_logged_out_user).to be false
      end

      it 'returns http success' do
        expect(response).to have_http_status(:ok)
        expect(response).to have_http_status(:success)
        expect(response).to have_http_status(200)
      end
    end

    context 'when user is not signed in' do
      before { get '/api/v1/reservations' }

      it 'returns http bad request of 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns error message' do
        expect(json['error']).to eq('You are not logged in. Please log in first.')
      end
    end
  end

  describe 'POST /api/v1/reservations' do
    before { post '/api/v1/sign_in', params: existing_username }

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

    let(:invalid_attributes) do
      {
        reservation: {
          date: Date.tomorrow,
          user_id: users.first.id,
          course_id: courses.second.id,
          city_id: 6
        }
      }
    end

    context 'when the request is valid' do
      before { post '/api/v1/reservations', params: valid_attributes }

      it 'creates a reservation' do
        expect(response.body)
          .to match(/Reservation created successfully/)
      end

      it 'returns a json response of size 3' do
        expect(json).not_to be_empty
        expect(json.size).to eq(3)
      end

      it 'returns status 200 in payload' do
        expect(json['status']).to eq(200)
      end

      it 'returns created course in json response' do
        reservation = JSON.parse(
          {
            user: users.first.name,
            course: courses.second.title,
            city: cities.third.name,
            date: Date.tomorrow
          }.to_json
        )

        expect(json['reservation']).to include(reservation)
      end

      it 'returns http success, ok and 200' do
        expect(response).to have_http_status(:ok)
        expect(response).to have_http_status(:success)
        expect(response).to have_http_status(200)
        expect(response).not_to have_http_status('created')
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/reservations', params: invalid_attributes }

      it 'returns a message' do
        expect(json['message']).to eq('Create reservation failed')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
        expect(response).to have_http_status(:success)
        expect(response).to have_http_status(200)
      end

      it 'returns a status 400 within json body' do
        expect(json['status']).to eq(400)
      end
    end
  end

  describe 'DELETE /api/v1/reservations/:id' do
    before { post '/api/v1/sign_in', params: existing_username }

    context 'when reservation exists in db' do
      before { delete "/api/v1/reservations/#{deleted_reservation.id}" }

      it 'returns deleted reservation in response body' do
        id = { 'id' => deleted_reservation.id }
        course_id = { 'course_id' => deleted_reservation.course_id }
        expect(json['reservation']).to include(id)
        expect(json['reservation']).to include(course_id)
      end

      it 'returns a message' do
        expect(json['message']).to eq('Reservation deleted successfully')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when course doesn\'t exist in db' do
      before { delete "/api/v1/reservations/#{deleted_reservation.id}" }
      before { delete "/api/v1/reservations/#{deleted_reservation.id}" }

      it 'returns a message' do
        expect(json['message']).to eq("Couldn't find Reservation with 'id'=#{deleted_reservation.id}")
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
