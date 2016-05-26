class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.belongs_to :exercise_set, index: true
      t.belongs_to :owner, index: true

      t.string :label

      t.timestamps null: false
    end
  end
end
