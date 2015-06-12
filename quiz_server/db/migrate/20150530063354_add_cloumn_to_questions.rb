class AddCloumnToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :status, :string, default: "prepared"
  end
end
