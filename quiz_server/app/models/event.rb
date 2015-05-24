class Event < ActiveRecord::Base
    has_many :questions
    has_many :answerers
    has_many :payments
    has_one :course
    belongs_to :admin_user

    default_scope ->{where(is_delete: false)}

    def set_url
      url_token = SecureRandom.urlsafe_base64
      self.update(url_token:url_token)
    end
end
