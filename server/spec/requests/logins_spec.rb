# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Logins API', type: :request do
  let!(:user) { create(:user) }
  let!(:logins) { create_list(:login, 10, user: user) }
  let(:login_id) { logins.first.id }

  describe 'GET /logins' do
    before { get '/logins' }

    it 'returns logins' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /logins/:id' do
    before { get "/logins/#{login_id}" }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(login_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:login_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Login/)
      end
    end
  end

  describe 'POST /logins' do
    let(:valid_attributes) do
      { username: 'test@spec', password: 's3cretss', site: 'test.spec',
        user_id: user.id }
    end

    context 'when the request is valid' do
      before { post '/logins', params: valid_attributes }

      it 'creates a todo' do
        expect(json['username']).to eq('test@spec')
        expect(json['password']).to eq('s3cretss')
        expect(json['site']).to eq('test.spec')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/logins', params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: User must exist/)
      end
    end
  end

  describe 'PUT /logins/:id' do
    let(:valid_attributes) { { password: '5tr0ngPWD' } }

    context 'when the record exists' do
      before { put "/logins/#{login_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /logins/:id' do
    before { delete "/logins/#{login_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
