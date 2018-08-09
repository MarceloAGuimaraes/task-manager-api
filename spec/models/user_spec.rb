require 'rails_helper'

RSpec.describe User, type: :model do
   it 'alo' do
    user = FactoryGirl.create(:user)
    expect(user).to respond_to(:password)
   end
end