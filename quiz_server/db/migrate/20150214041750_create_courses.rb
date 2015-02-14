class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
        t.string   :name, null: false, default: ""
        t.integer  :max_answerer, null: false
        t.integer  :max_question, null: false
        t.integer  :price, null: false

      t.timestamps
    end
  end
end
