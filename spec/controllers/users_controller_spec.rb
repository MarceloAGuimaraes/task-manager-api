require 'rails_helper'

RSpec.describe  Api::V1::UsersController, type: :controller do

    context 'as a guest' do
        it 'esperando que o email seja igual ao criado na factory' do
          user = create(:user)
          get :show, params: { id: user.id }
          expect(User.first.email).to eq("alo@hotmail.com")
        end
    end

    context 'as a guest' do
        it '200 expect to response' do
          user = create(:user)

          params = Hash.new
          params = { password: "testedesoftware"}
          put :update, params: { id: user.id, user_params: params}
          user.reload
          expect(user.password).to eq("testedesoftware")
        end
    end
    
end