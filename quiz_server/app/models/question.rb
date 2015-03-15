class Question < ActiveRecord::Base
    has_many :choises
    has_one :question_type
    has_many :answerers
    belongs_to :event
end
