class Exercise < ActiveRecord::Base
  belongs_to :exercise_set
  has_many :trainings
  has_many :users, through: :trainings, dependent: :delete_all
  belongs_to :owner, class_name: "User"
end
