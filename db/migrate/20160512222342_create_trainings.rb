class CreateTrainings < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.belongs_to :user, index:true
      t.belongs_to :exercise, index:true

      t.string :period
      t.datetime :next

      t.timestamps null: false
    end
  end
end
