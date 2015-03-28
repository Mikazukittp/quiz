class AddIsDeleteToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :is_delete, :boolean, :after => :locked_at
  end
end
