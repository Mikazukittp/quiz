class AddToAnswerersRank < ActiveRecord::Migration
  def change
    add_column :answerers, :rank, :integer, :after => :name
  end
end
