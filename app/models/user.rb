class User < ActiveRecord::Base

	belongs_to :org
	has_many :janhours
	has_many :febhours
	has_many :marhours
	has_many :hours
	has_many :aprhours
	has_many :mayhours
	has_many :junhours
	has_many :julhours
	has_many :aughours
	has_many :sephours
	has_many :octhours
	has_many :novhours
	has_many :dechours
	has_many :events
	has_many :attendances, foreign_key: "attendee_id", dependent: :destroy
	has_many :attended_events, through: :attendances, source: :event

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w\-.]+@(atma)[a-zA-Z\.]+\Z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
										uniqueness: { case_sensitive: false }
	#Uncomment to make org_id compulsary: validates :org_id, presence: true
	validates :start_date, presence: true

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

	def attending?(event)
		self.attendances.find_by(event_id: event.id)
	end

	def attend!(event)
		self.attendances.create!(event_id: event.id)
	end

	def unattend!(event)
		self.attendances.find_by(event_id: event.id).destroy
	end

	private

		def create_remember_token
			self.remember_token = User.digest(User.new_remember_token)
		end
end
