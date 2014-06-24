class User < ActiveRecord::Base

	belongs_to :org
	has_many :janhours

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w\-.]+@(atma)[a-zA-Z\.]+\Z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
										uniqueness: { case_sensitive: false }

	#Uncomment to make org_id compulsary: validates :org_id, presence: true

	before_save { self.email = email.downcase }

	before_create :create_remember_token

	has_secure_password
	validates :password, length: { minimum: 6 }

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

		def create_remember_token
			self.remember_token = User.digest(User.new_remember_token)
		end
end
