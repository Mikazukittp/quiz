class RenameTypeIdColumnToQuestions < ActiveRecord::Migration
  def change
    rename_column :questions, :type_id, :question_type_id
  end
end
