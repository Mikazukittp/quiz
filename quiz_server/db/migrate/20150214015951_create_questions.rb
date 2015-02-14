class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
        t.integer  :event_id, null: false
        t.integer  :question_number, null: false, default: 1
        t.string   :sentence, null: false, default: ""
        t.integer  :points, null: false, default: 1
        t.integer  :type_id, null: false
        t.boolean  :is_delete,null: false, default: false

      t.timestamps
    end
  end
end
