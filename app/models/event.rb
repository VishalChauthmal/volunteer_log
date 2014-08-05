class Event < ActiveRecord::Base
	belongs_to :user

	validates :title, presence: true
	validates :event_date, presence: true

	has_many :reverse_attendances, foreign_key: "event_id", class_name: "Attendance", dependent: :destroy
	has_many :attendees, through: :reverse_attendances, source: :attendee
end
