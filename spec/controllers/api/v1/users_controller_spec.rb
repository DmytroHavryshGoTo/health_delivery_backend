require 'rails_helper'

RSpec.describe 'Users controller', type: :request do
  context 'POST api/v1/users' do
    let(:user_params) do
      {
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet::email,
        password: Faker::Internet::password
      }
    end

    context 'valid params' do
      it 'creates new user' do
        post '/api/v1/users', params: user_params
        expect(response).to have_http_status(201)
      end
    end

    context 'invalid params' do
      let!(:user1) { create(:user) }

      it 'does not create new user because user already created' do
        user_params[:email] = user1.email
        post '/api/v1/users', params: user_params
        expect(response).to have_http_status(422)
      end

      it 'does not create new user because user already created' do
        user_params[:email] = ''
        post '/api/v1/users', params: user_params
        expect(response).to have_http_status(422)
      end
    end
  end
end
