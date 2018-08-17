require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
    let!(:user) { FactoryGirl.create(:user)}
    let(:user_id) { user.id }
    let(:headers) do 
    {
      'Accept' => 'application/vnd.taskmanager.v1',
      'Content-Type' => Mime[:json].to_s,
      'Authorization' => user.auth_token
    } end


    before { host! 'api.task-manager.test'}

    describe 'GET /users' do
       before do
        get "/users/#{user_id}", params: {}, headers: headers 
       end
           
       context 'when the user exist' do
        it 'returns the user' do
          expect(json_body[:id]).to eq(user_id)
        end

        it ' return 200' do
          expect(response).to have_http_status(200)
        end
       end
    end

    describe "POST e puts /users" do
        before do
          
          post '/users', params: { user: user_params }.to_json, headers: headers
        end
    
        context 'when the request params are valid' do
          let(:user_params) { FactoryGirl.attributes_for(:user) }
 
          it 'returns the json data for the created user' do
            
              expect(json_body[:email]).to match(user_params['email'])
          end
        end
    
        context 'when the request params are invalid' do
          let(:user_params) { attributes_for(:user, email: 'invalid.email@') }
    
          it 'returns status code 422' do
            expect(response).to have_http_status(422)
          end
    
          it 'returns the json data for the errors' do
              expect(json_body).to have_key(:errors)
          end
        end
      end
      
    describe 'put #update' do
      before do
        
        put "/users/#{user_id}", params: { user: user_params}.to_json, headers: headers
        end

        context 'when te request params are valid' do
          let(:user_params) { { email: 'new@hotmail.com'} }
          it 'returns status 200' do
             expect(response).to have_http_status(200)
          end

          it 'return json' do
            expect(json_body[:email]).to eq(user_params[:email])
          end
        end
    end
    describe 'DELETE' do
      before do      
        delete "/users/#{user_id}", params: {}, headers: headers
      end

      context 'delete #destroy status' do
        it 'by status' do 
          expect(response).to have_http_status(204)  
        end
      end
    end
  end
