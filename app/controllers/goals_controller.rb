class GoalsController < ApplicationController
  before_action :authorize

  def create
    goal = @user.goals.new(goal_params)

    if goal.save
      render json: { goal: goal }, status: :created
    else
      render json: { errors: goal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @goal = @user.goals.find(params[:id])

    if @goal.update(goal_params)
      render json: { goal: @goal }, status: :created
    else
      render json: { errors: @goal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:description, :amount, :target_date)
  end
end
