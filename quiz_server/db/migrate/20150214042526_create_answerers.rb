class CreateAnswerers < ActiveRecord::Migration
  def change
    create_table :answerers do |t|
        t.integer  :event_id, null: false
        t.string   :name, null: false, default: ""
        t.integer  :total_points, null: false
        t.integer  :total_times_answer_correctly, null: false
        t.integer  :total_answer_time, null: false

      t.timestamps
    end
  end
end
