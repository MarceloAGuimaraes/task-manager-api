class Api::V1::UsersController < ApplicationController
     respond_to :json
   begin       
     def show 
       @user = User.find(params[:id])
       respond_with @user
    end
    rescue
      head 404
   end

   def create 
    user = User.new(user_params)

    if user.save
      render json: user, status: 201
    end
   end


   private 

   def user_params
     params.require(:user).permit(
       :email,
       :password
     )

   end
end
