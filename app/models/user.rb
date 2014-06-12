class User < ActiveRecord::Base

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w\-.]+@(atma)[a-zA-Z\.]+\Z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
										uniqueness: { case_sensitive: false }

	before_save { self.email = email.downcase }

	has_secure_password
	validates :password, length: { minimum: 6 }
end
