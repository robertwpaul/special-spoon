require 'rails_helper'

RSpec.describe 'events API', type: :request do
  let!(:events) { create_list(:event, 5) }
  let(:event_id) { events.first.id }

  describe 'GET /events' do
    before { get '/events' }

    it { expect(json).not_to be_empty }
    it { expect(json.size).to eq(5) }
    it { expect(response).to have_http_status(:ok) }
  end

  describe 'GET /events/:id' do
    before { get "/events/#{event_id}"}

    context 'when the event exists' do
      it { expect(json['id']).to eq(event_id) }
    end

    context 'when the event does not exist' do
      let(:event_id) { 99999 }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'POST /events' do
    before { post '/events', params: params }

    context 'when the request is valid' do
      let(:params) { { title: 'Test Event', zip: '12345'} }

      it { expect(json['title']).to eq('Test Event') }
      it { expect(response).to have_http_status(:created) }
    end

    context 'when the request is invalid' do
      let(:params) { { title: 'Foo' } }

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(response.body).to match(/Zip can't be blank/) }
    end
  end

  describe 'PUT /events/:id' do
    let(:params) { { title: 'Updated Event' } }

    before { put "/events/#{event_id}", params: params }

    context 'when the Event exists' do
      it { expect(response).to have_http_status(:no_content) }
    end

    context 'when the Event does not exist' do
      let(:event_id) { 99999 }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'DELETE /events/:id' do
    before { delete "/events/#{event_id}" }

    context 'when the Event exists' do
      it { expect(response).to have_http_status(:no_content) }
      it { expect(Event.count).to eq(4) }
    end

    context 'when the Event does not exist' do
      let(:event_id) { 99999 }

      it { expect(response).to have_http_status(:not_found) }
    end
  end
end