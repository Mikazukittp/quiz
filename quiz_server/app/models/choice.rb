class Choice < ActiveRecord::Base
    belongs_to :question

    default_scope ->{where(is_delete: false)}
end
