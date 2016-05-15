class CreateTrainings < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.string :period
      t.datetime :next

      t.timestamps null: false
    end
  end
end
