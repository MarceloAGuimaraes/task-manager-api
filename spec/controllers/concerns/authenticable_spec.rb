require 'rails_helper'

RSpec.describe Authenticable do
    controller(ApplicationController) do
        include Authenticable
    end

    let(:app_controller) { subject}
    describe 'current_user ' do
       let(:user) { create(:user)}
        
       before do
          req = double(:headers => { 'Authorization' => user.auth_token})
          allow(app_controller).to receive(:request).and_return(req)
       end

        it 'return the user from the authorization header' do
          expect(app_controller.current_user).to eq(user)
        end
    end

    describe 'authenticate_with_token! before de update and destroy requests' do
       controller do
          before_action :authenticate_with_token!

          def restricted_action
          end
       end

       context 'where is no user logged in' do
        before do
           allow(app_controller).to receive(:current_user).and_return(nil)
           routes.draw { get 'restricted_action' => 'anonymous#restricted_action' }
           get :restricted_action
        end

        it 'status code 401' do
          expect(response).to have_http_status(401)
        end

        it 'return the json for data errors' do
          expect(json_body).to have_key(:errors)
        end
       end
    end

    describe '#user_logged_in?' do
      context 'when there is a user logged in' do
        before do 
          user = create(:user)
            allow(app_controller).to receive(:current_user).and_return(user)
        end 
        it{ expect(app_controller.user_logged_in?).to be_truthy }
      end
      
      context 'no user loged in' do
        before do 
          user = create(:user)
            allow(app_controller).to receive(:current_user).and_return(nil)
        end
        it { expect(app_controller.user_logged_in?).to be false }
      end
    end
end