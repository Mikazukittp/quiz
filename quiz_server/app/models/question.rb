class Question < ActiveRecord::Base
    has_many :choices
    belongs_to :question_type
    has_many :answers
    belongs_to :event

    default_scope ->{where(is_delete: false)}
end
