class SessionsController < ApplicationController
  def create
    user = User.authenticate(params[:username], params[:password])

    if user
      render json: { token: token(user.id), user_id: user.id }, status: :created
    else
      render json: { errors: ['Username or Password is incorrect'] }, status: :unprocessable_entity
    end
  end
end
