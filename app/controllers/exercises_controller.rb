class ExercisesController < ApplicationController
  def new
    @exercise = Exercise.new
  end

  def index
    @exercises = Exercise.all
  end

  def debug
    @exercises = Exercise.all.order(:next)
  end

  def create
    @exercise = Exercise.create(exercise_params)
    @exercise.next = Time.now
    if @exercise.save
      flash[:success] = 'Exercise saved!'
      redirect_to new_exercise_url
    end
  end

  def destroy
    exercise = Exercise.find(params[:id])
    if exercise.training
      exercise.training.delete
    end
    exercise.delete
    redirect_to :back
  end

  private

  def exercise_params
    params.require(:exercise).permit(:label)
  end

end
