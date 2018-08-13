require 'rails_helper'

RSpec.describe User, type: :model do
    let!(:user) { FactoryGirl.create(:user)}

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to validate_uniqueness_of(:auth_token) }
 
    describe 'infos' do
       it 'return email, created_at and token test' do
         user.save!
         allow(Devise).to receive(:friendly_token).and_return('abc2234')

         expect(user.info).to eq("#{user.email} - #{user.created_at} - Token: abc2234")
       end
    end

    describe 'generate_autentication_token' do
       it 'valid' do
        allow(Devise).to receive(:friendly_token).and_return('abc2234')
        
        user.generate_authentication_token!

        expect(user.auth_token).to eq('abc2234')
       end
    end
end