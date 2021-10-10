require 'rails_helper'

RSpec.describe 'Auth controller', type: :request do
  context 'POST api/v1/sign_in' do
    let!(:user) { create(:user, password: 'password1234') }

    context 'valid params' do
      it 'returns JWT token' do
        post '/api/v1/sign_in', params: { email: user.email, password: 'password1234' }
        expect(json_body.dig('meta', 'token')).to_not be_empty
        expect(response).to have_http_status(201)
      end
    end

    context 'invalid params' do
      it 'returns JWT token' do
        post '/api/v1/sign_in', params: { email: user.email, password: '123' }
        expect(response).to have_http_status(401)
      end
    end
  end
end
