class TrainingController < ApplicationController
  before_action :connected_user, only: [:index, :debug, :destroy, :add_exercise,
                                        :add_exercise_set, :failed, :done]

  def index
    @trainings = @user_connected.trainings.where('NEXT IS NULL OR NEXT<?', DateTime.now).order(:next)
    # OR NEXT<?', DateTime.now
  end

  def debug
    @trainings = @user_connected.trainings.all.order(:next)
  end

  def destroy
    @user_connected.trainings.find(params[:id]).delete
    redirect_to :back
  end

  def add_exercise
    unless @user_connected.exercises.find(params[:id]).exists?
      @user_connected.exercises << Exercise.find(params[:id])

      training = @user_connected.trainings.where(:exercise_id => params[:id])
      training.next = DateTime.now
    end
    redirect_to :back
  end

  def add_exercise_set
    exercise_set = ExerciseSet.find(params[:id])
    exercise_set.exercises.each do |exercise|
      unless @user_connected.exercises.where(:id => exercise.id).exists?
        @user_connected.exercises << exercise

        training = @user_connected.trainings.where(:exercise_id => exercise.id).first
        training.next=DateTime.now
      end
    end
    redirect_to :back
  end

  def done
    @training = @user_connected.trainings.find(params[:id])
    case @training.period
      when 'hour'
        @training.period = 'day'
        @training.next = Time.now + 1.day
      when 'day'
        @training.period = 'week'
        @training.next = Time.now + 1.week
      when 'week'
        @training.period = 'month'
        @training.next = Time.now + 1.month
      when 'month'
        @training.period = 'trimester'
        @training.next = Time.now + 3.months
      when 'trimester'
        @training.period = 'semester'
        @training.next = Time.now + 6.months
      when 'semester'
        @training.period = 'year'
        @training.next = Time.now + 1.year
      when 'year'
        @training.period = 'year'
        @training.next = Time.now + 1.year
      else
        @training.period = 'hour'
        @training.next = Time.now + 1.hour
    end

    @training.save

    redirect_to :back
  end

  def failed
    @training = @user_connected.trainings.find(params[:id])
    @training.next = Time.now
    @training.period = nil
    @training.save

    redirect_to :back
  end

  private

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
