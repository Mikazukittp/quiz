class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
        t.integer  :question_id, null: false
        t.integer  :answerer_id, null: false
        t.integer  :answer_time, null: false
        t.integer  :choice_question_number, null: false
        t.boolean  :is_correct, null: false, default:true

      t.timestamps
    end
  end
end
