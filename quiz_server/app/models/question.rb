class Question < ActiveRecord::Base
    has_many :choices
    belongs_to :question_type
    has_many :answerers
    belongs_to :event
end
