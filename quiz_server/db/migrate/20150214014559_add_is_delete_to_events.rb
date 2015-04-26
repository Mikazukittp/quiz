class AddIsDeleteToEvents < ActiveRecord::Migration
  def change
    add_column :events, :is_delete, :boolean,null: false, default: false
  end
end
