class Event < ActiveRecord::Base
    has_many :questions
    has_many :answers, through: :questions
    has_many :answerers
    has_many :payments
    has_one :course
    belongs_to :admin_user

    default_scope ->{where(is_delete: false)}

    def set_url_token
      url_token = SecureRandom.urlsafe_base64
      self.update(url_token:url_token, status: "ready")
    end

    def is_free_plan?
        self.course_id == 1
    end

    def is_paid?
        self.url_token != ""
    end
end
