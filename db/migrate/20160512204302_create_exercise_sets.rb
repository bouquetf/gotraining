class CreateExerciseSets < ActiveRecord::Migration
  def change
    create_table :exercise_sets do |t|
      t.belongs_to :owner, index: true
      t.string :name

      t.timestamps null: false
    end
  end
end
