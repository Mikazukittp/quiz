class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
        t.integer  :event_id, null: false
        t.datetime :date, null: true
        t.datetime :limit_date, null: false
        t.integer  :amount, null: true
        t.boolean  :is_delete, null: false, default:false

      t.timestamps
    end
  end
end
