class RenameTotalTimesAnswerCorrectlyColumnToAnswerers < ActiveRecord::Migration
  def change
    rename_column :answerers, :total_times_answer_correctly, :correct_answers
    rename_column :answerers, :total_answer_time, :avarage_answer_time
  end
end
