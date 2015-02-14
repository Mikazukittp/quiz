class CreateQuestionTypes < ActiveRecord::Migration
  def change
    create_table :question_types do |t|
        t.string  :name, null: false, default:""
      t.timestamps
    end
  end
end
