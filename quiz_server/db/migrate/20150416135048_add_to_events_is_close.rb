class AddToEventsIsClose < ActiveRecord::Migration
  def change
    add_column :events, :is_close, :boolean, default: true
  end
end
