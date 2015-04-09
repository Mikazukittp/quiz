class AddIsCurrentFlagToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :is_current, :boolean
  end
end
