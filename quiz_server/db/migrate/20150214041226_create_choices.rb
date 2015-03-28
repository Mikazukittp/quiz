class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
        t.integer  :question_id, null: false
        t.string   :sentence, null: false, default: ""
        t.boolean  :correct_flag, null: false, default: false
        t.integer  :choice_number, null: false
        t.integer  :answered_times, null: false
        t.string   :image_url, null: true
        t.string   :thumbnail_image_url, null: true
        t.boolean  :is_delete,null: false, default: false

      t.timestamps
    end
  end
end
