class User < ActiveRecord::Base
  has_many :trainings
  has_many :exercises, -> { distinct }, through: :trainings

  has_secure_password
end
