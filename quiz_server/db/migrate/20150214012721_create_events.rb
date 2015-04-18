class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
        t.integer  :admin_user_id, null: false
        t.string   :name, null: false, default: ""
        t.datetime :event_date, null: false
        t.datetime :limit_date, null: false
        t.integer  :time_limit, null: false, default: 60
        t.string   :url, null: false

      t.timestamps
    end
  end
end
