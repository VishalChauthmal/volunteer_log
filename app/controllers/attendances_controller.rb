class AttendancesController < ApplicationController

	before_action :signed_in_user

	def create
		@event = Event.find(params[:attendance][:event_id])
		current_user.attend!(@event)
		redirect_to @event
	end

	def destroy
		@event = Attendance.find(params[:id]).event
		current_user.unattend!(@event)
		redirect_to @event
	end
end
