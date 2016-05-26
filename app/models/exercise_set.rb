class ExerciseSet < ActiveRecord::Base
  has_many :exercises
  belongs_to :owner, class_name: 'User'
end
