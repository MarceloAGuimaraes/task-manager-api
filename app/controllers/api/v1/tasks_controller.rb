class Api::V1::TasksController < ApplicationController
    before_action :authenticate_with_token!
    respond_to :json
    def index 
      render json: { tasks: current_user.tasks}, status: 200
    end

    def update
       task = current_user.tasks.find(params[:id])
       if task.update_attributes(task_params)
         render json: task, status: 200
       else
        render json: { errors: task.errors}, status: 422
        end
    end

    def destroy
      task = current_user.tasks.find(params[:id])
      task.destroy
      head 404
    end
    def show
       task = current_user.tasks.find(params[:id])
       render json: task , status: 200
    end

    def create
      task = current_user.tasks.build(task_params)
      if task.save
        render json: task, status: 201
      else
        render json: { errors: task.errors }, status: 422
      end
    end

   def task_params
    params.require(:task).permit(
      :title,
      :description,
      :deadline
    )
   end
end
