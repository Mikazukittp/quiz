class AddColumnToQuestionTypes < ActiveRecord::Migration
  def change
    add_column :question_types, :question_id, :integer, :after => :name
  end
end
