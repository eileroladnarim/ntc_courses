class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :courses
      t.string :instructor
      t.string :training_manager
      t.integer :actual_number_of_days
      t.string :schedule_type
      t.integer :available_slots
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
