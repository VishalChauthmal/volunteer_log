class EventsController < ApplicationController

	before_action :signed_in_user
	before_action :authorized_user_to_destroy, only: [:destroy]

	def new
		@event = current_user.events.build
	end

	def create
		@event = current_user.events.build(event_params)
		if @event.save
			flash[:success] = "Event created successfully!"
			redirect_to @event
		else
			render 'new'
		end
	end

	def show
		@event = Event.find(params[:id])
	end

	def edit
		@event = Event.find(params[:id])
	end

	def update
		@event = Event.find(params[:id])
		if @event.update_attributes(event_params)
			flash[:success] = "Event updated successfully!"
			redirect_to @event
		else
			render 'edit'
		end
	end

	def index
		@events = Event.all
		@date = params[:month] ? Date.parse(params[:month]) : Date.today
	end

	def destroy
		@event.destroy
		flash[:success] = "The event is deleted."
		redirect_to events_url
	end

	def attendees
		@title = "Attendees"
		@event = Event.find(params[:id])
		@users = @event.attendees
		render 'attendees'
	end

	private
		def event_params
			params.require(:event).permit(:event_date, :event_time, :venue, :user_id, :title, 
											:description)
		end

		def authorized_user_to_destroy
			@event = current_user.events.find_by(id: params[:id])
			redirect_to events_url if @event.nil?
		end
end
