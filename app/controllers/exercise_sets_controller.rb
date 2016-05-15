class ExerciseSetsController < ApplicationController
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
    if @exercise_set.save
      flash[:success] = 'Exercise saved!'
      redirect_to action: "show", id: @exercise_set.id
    else
      redirect_to new
    end
  end

  def add_exercise
    @exercise_set = ExerciseSet.find(params[:id])
    @exercise_set.exercises.create(exercise_params)
    redirect_to action: 'show', id: @exercise_set.id
  end

  def destroy
    ExerciseSet.find(params[:id]).delete
    redirect_to :back
  end

  private

  def exercise_set_params
    params.require(:exercise_set).permit(:name)
  end

  def exercise_params
    params.require(:exercise).permit(:label)
  end

end
