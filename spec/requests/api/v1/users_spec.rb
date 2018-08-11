require 'rails_helper'

RSpec.describe 'Users API', type: :request do
    let!(:user) { FactoryGirl.create(:user)}
    let(:user_id) { user_id}

    before { host! 'api.task-manager.test'}

    describe 'GET /users' do
       before do
        headers = { "Accept" => "application/vnd.taskmanager.v1"}
        get "/users/#{user_id}", params: {}, headers: headers 
       end
           
       context 'when the user exist' do
        it 'returns the user' do
          user_response = JSON.parse(response.body)
          expect(user_response["id"]).to eq(user_id)
        end

        it ' return 200' do
          expect(response).to have_http_status(200)
        end
       end
    end

end