class AddCourseIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :course_id, :integer, :after => :admin_user_id
  end
end
