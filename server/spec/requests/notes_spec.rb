# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Notes API', type: :request do
  let!(:user) { create(:user) }
  let!(:notes) { create_list(:note, 10, user: user) }
  let(:note_id) { notes.first.id }
  let(:headers) { valid_headers }

  describe 'GET /notes' do
    before { get '/notes', params: {}, headers: headers }

    it 'returns notes' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /notes/:id' do
    before { get "/notes/#{note_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(note_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:note_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Note/)
      end
    end
  end

  describe 'POST /notes' do
    let(:valid_attributes) do
      { title: 'GitHub 2FA Keys', content: 'GitHub Keys', user_id: user.id }
    end

    context 'when the request is valid' do
      before { post '/notes', params: valid_attributes, headers: headers }

      it 'creates a todo' do
        expect(json['title']).to eq('GitHub 2FA Keys')
        expect(json['content']).to eq('GitHub Keys')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/notes', params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  describe 'PUT /notes/:id' do
    let(:valid_attributes) { { title: 'Amazon Cupom' } }

    context 'when the record exists' do
      before do
        put "/notes/#{note_id}", params: valid_attributes, headers: headers
      end

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /notes/:id' do
    before { delete "/notes/#{note_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
