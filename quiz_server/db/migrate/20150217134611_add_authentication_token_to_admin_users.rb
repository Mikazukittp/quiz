class AddAuthenticationTokenToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :authentication_token, :string, unique: true
  end
end
