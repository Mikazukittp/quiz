class AddToUrlTokenEvent < ActiveRecord::Migration
  def change
    add_column :events, :url_token, :string
  end
end
