class Api::V1::SessionsController < ApplicationController
    def create
      user = User.find_by(email: session_params[:email])
        
      if user && user.valid_password?(session_params[:password]) 
        sign_in user, store: false
        user.generate_authentication_token!
        user.save
        render json: user, status: 200
      else
        render json: { errors: 'invalid password or email'}, status: 401
      end
    end

    def destroy
      user = User.find_by(auth_token: params[:id])
      begin
      user.generate_authentication_token!
      user.save!
      render json: user, status: 204
      rescue
      render json: user, status: 401
      end
    end
    private

    def session_params
       params.require(:session).permit(:email, :password)
    end
end
