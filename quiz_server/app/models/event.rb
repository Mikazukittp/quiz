class Event < ActiveRecord::Base
    has_many :questions
    has_many :answerers
    has_many :payments
    has_one :course
    belongs_to :admin_user

    default_scope ->{where(is_delete: false)}
end
