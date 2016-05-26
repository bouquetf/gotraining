class ExercisesController < ApplicationController
  before_action :connected_user, only: [:new, :create, :destroy]

  def new
    @exercise = Exercise.new
  end

  def index
    @exercises = Exercise.all
  end

  def create
    @exercise = Exercise.create(exercise_params)
    @exercise.owner = @user_connected
    @exercise.exercise_set_id=params[:exercise_set_id]
    if @exercise.save
      flash[:success] = 'Exercise saved!'
      redirect_to :back
    end
  end

  def destroy
    exercise = Exercise.find(params[:id])
    exercise.destroy
    redirect_to :back
  end

  private

  def exercise_params
    params.require(:exercise).permit(:label)
  end

  def connected_user
    begin
      if session[:user_id] != nil
        @user_connected = User.find(session[:user_id])
      else
        redirect_to sign_in_path
      end
    rescue ActiveRecord::RecordNotFound
      session[:user_id] = nil
      redirect_to sign_in_path
    end
  end

end
