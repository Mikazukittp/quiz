class AddUserTokenToAnswerer < ActiveRecord::Migration
  def change
    add_column :answerers, :user_token, :string
  end
end
