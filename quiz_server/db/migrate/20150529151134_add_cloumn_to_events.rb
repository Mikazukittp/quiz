class AddCloumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :status, :string, default: "prepared"
  end
end
