require 'rails_helper'

RSpec.describe Authenticable do
    controller(ApplicationController) do
        include Authenticable
    end

    describe 'current_user ' do
       let(:user) { create(:user)}
        
       before do
          req = double(:headers => { 'Authorization' => user.auth_token})
          allow(subject).to receive(:request).and_return(req)
       end

        it 'return the user from the authorization header' do
          expect(subject.current_user).to eq(user)
        end
    end
end