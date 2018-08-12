require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
     it 'ola' do
        expect(response).to have_http_status(200)
     end
end
