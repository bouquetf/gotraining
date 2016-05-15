class Exercise < ActiveRecord::Base
  belongs_to :exercise_set
  belongs_to :training
end
