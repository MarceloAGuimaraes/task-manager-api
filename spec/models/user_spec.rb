require 'rails_helper'

RSpec.describe User, type: :model do
    let!(:user) { FactoryGirl.create(:user)}

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to validate_uniqueness_of(:auth_token) }
end