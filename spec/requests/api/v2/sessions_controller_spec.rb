require 'rails_helper'

RSpec.describe 'Sessions API', type: :request do
  before { host! 'api.taskmanager.dev' }
  let(:user) { create(:user, password: "2030") }
  let(:headers) do
    {
      'Accept' => 'application/vnd.task-manager.v1',
      'Content-Type' => Mime[:json].to_s
    }
  end

  describe 'POST /sessions' do
    before do
      post '/sessions', params: { session: credentials }.to_json, headers: headers
    end

    context 'when the credentials are correct' do
      let(:credentials) { { email: user.email, password: 'sorrirparanao' } }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the json data for the user with auth token' do
        user.reload
        expect(json_body[:user][:auth_token]).to eq(user.auth_token)
      end
    end

    context 'when the credentials are incorrect' do
      let(:credentials) { { email: user.email, password: 'invalid_password' } }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end

      it 'returns the json data for the errors' do
        expect(json_body).to have_key(:errors)
      end
    end
  end

  describe 'delete /sessions/#{auth_token}' do
      let(:auth_token) { user.auth_token }

      before do
        delete "/sessions/#{auth_token}", params: {} , headers: headers
      end

      it 'returns 204 http status code' do
          expect(response).to have_http_status(204)
      end

      it 'changes the user auth token' do
        expect(User.find_by(auth_token: auth_token) ).to be_nil
      end
  end
end