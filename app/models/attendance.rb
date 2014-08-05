class Attendance < ActiveRecord::Base
	belongs_to :attendee, class_name: "User"
	belongs_to :event, class_name: "Event"

	validates :attendee_id, presence: true
	validates :event_id, presence: true
end
