class ExerciseSetsController < ApplicationController
  before_action :connected_user, only: [:new, :create, :add_exercise, :destroy]

  def index
    @exercise_sets = ExerciseSet.all
  end

  def show
    @exercise_set = ExerciseSet.find(params[:id])
    @exercise = Exercise.new
  end

  def new
    @exercise_set = ExerciseSet.new
  end

  def create
    @exercise_set = ExerciseSet.create(exercise_set_params)
    @exercise_set.owner = @user_connected

    if @exercise_set.save
      flash[:success] = 'Exercise saved!'
      redirect_to action: "show", id: @exercise_set.id
    else
      redirect_to new
    end
  end

  def add_exercise
    @exercise_set = ExerciseSet.find(params[:id])
    # @exercise_set.exercises.create(exercise_params)
    redirect_to controller:'exercises', action: 'create', id: @exercise_set.id
  end

  def destroy
    exercise_set = ExerciseSet.find(params[:id])
    if exercise_set.owner == @user_connected
      exercise_set.delete
    end

    redirect_to :back
  end

  private

  def exercise_set_params
    params.require(:exercise_set).permit(:name)
  end

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
