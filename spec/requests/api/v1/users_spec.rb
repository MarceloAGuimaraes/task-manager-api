require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
    let!(:user) { FactoryGirl.create(:user)}
    let(:user_id) { user.id }

    before { host! 'api.task-manager.test'}

    describe 'GET /users' do
       before do
        headers = { 'Accept' => 'application/vnd.taskmanager.v1'}
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
    describe "POST /users" do
        before do
          headers = { "Accept" => "application/vnd.taskmanager.v1" }
          post '/users', params: { user: user_params }, headers: headers
        end
    
        context 'when the request params are valid' do
          let(:user_params) { FactoryGirl.attributes_for(:user) }
 
          it 'returns the json data for the created user' do
            
            user_response = JSON.parse(response.body)
            expect(user_response['email']).to match(user_params['email'])
          end
        end
    
        context 'when the request params are invalid' do
          let(:user_params) { attributes_for(:user, email: 'invalid.email@') }
    
          it 'returns status code 422' do
            expect(response).to have_http_status(422)
          end
    
          it 'returns the json data for the errors' do
            user_response = JSON.parse(response.body)
            expect(user_response).to have_key('errors')
          end
        end
      end
      
      describe 'put #update' do
        before do
          headers = { 'Accept' => 'aplication/vnd.taskmanager.v1'}
          put "/users/#{user_id}", params: { user: user_params}, headers: headers
        end

        context 'when te request params are valid' do
          let(:user_params) { { email: 'new@hotmail.com'} }
          it 'returns status 200' do
             expect(response).to have_http_status(200)
          end

          it 'return json' do
            user_response = JSON.parse(response.body, symbolize_names: true)
            expect(user_response[:email]). to eq(user_params[:email])
          end
        end
      end
  
end