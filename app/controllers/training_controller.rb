class TrainingController < ApplicationController
  def index
    @trainings = Training.where('next < ?', DateTime.now).order(:next)
  end

  def debug
    @trainings = Training.all.order(:next)
  end

  def destroy
    Training.find(params[:id]).delete
    redirect_to :back
  end

  def add_exercise
    exercise = Exercise.find(params[:id])
    if exercise.training == nil
      Training.create(:exercise => exercise, :next => DateTime.now).save
    end

    redirect_to :back
  end

  def add_exercise_set
    exercise_set = ExerciseSet.find(params[:id])
    exercise_set.exercises.each do |exercise|
      if exercise.training == nil
        Training.create(:exercise => exercise, :next => DateTime.now).save
      end
    end
    redirect_to :back
  end

  def done
    @training = Training.find(params[:id])
    case @training.period
      when 'hour'
        @training.period = 'day'
        @training.next = @training.next + 1.day
      when 'day'
        @training.period = 'week'
        @training.next = @training.next + 1.week
      when 'week'
        @training.period = 'month'
        @training.next = @training.next + 1.month
      when 'month'
        @training.period = 'trimester'
        @training.next = @training.next + 3.months
      when 'trimester'
        @training.period = 'semester'
        @training.next = @training.next + 6.months
      when 'semester'
        @training.period = 'year'
        @training.next = @training.next + 1.year
      when 'year'
        @training.period = 'year'
        @training.next = @training.next + 1.year
      else
        @training.period = 'hour'
        @training.next = @training.next + 1.hour
    end

    @training.save

    redirect_to :back
  end

  def failed
    @training = Training.find(params[:id])
    @training.next = Time.now
    @training.period = nil
    @training.save

    redirect_to :back
  end
end
