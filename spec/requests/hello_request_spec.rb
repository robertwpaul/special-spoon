require 'rails_helper'

RSpec.describe 'hello API', type: :request do

  describe 'GET /hello' do
    before { get '/hello' }

    it 'returns a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns a Hello World message' do
      expect(json).not_to be_empty
    end
  end
end