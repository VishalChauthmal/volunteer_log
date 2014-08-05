require 'spec_helper'

describe "Event" do
	let(:user) { FactoryGirl.create(:user) }
	
	subject { page }

	describe "new page" do

		describe "without signing in" do
			before { visit new_event_path }

			it { should have_content('Sign In') }
		end

		describe "with signed in user" do

			before do
				sign_in user
				visit new_event_path
			end

			it { should have_title('New Event') }
			it { should have_content('Create New Event') }

			describe "with invalid event creation" do
				before { click_button "Create Event" }

				it { should have_selector('div.alert.alert-error') }
				it { should have_content('Create New Event') }
			end

			describe "with valid event creation" do
				before do
					fill_in "Event Title", with: "Vol Meeting"
					fill_in "Date", with: "2014-09-08"
					fill_in "Time", with: "10:15:00"
					fill_in "Venue", with: "Vol Room"
					fill_in "Event Description", with: "All the description"
					click_button "Create Event"
				end

				it { should have_selector('div.alert.alert-success') }
				it { should have_content('Event') }
				it { should have_content('Vol Meeting') }
			end
		end
	end

	describe "show page" do

		let(:event) { FactoryGirl.create(:event, user: user) }

		describe "without signing in" do
			before { visit event_path(event) }
			it { should have_content('Sign In') }
		end

		describe "with signed in user" do
			before do
				sign_in user
				visit event_path(event)
			end

			it { should have_title('Event | Vol Professional Meet') }
			it { should have_content('Vol Professional Meet') }

			describe "attendees count" do
				before do
					user.attend!(event)
					visit event_path(event)
				end

				it { should have_link("1 Attendee", href: attendees_event_path(event)) }
			end
		end

		describe "Attend/Unattend buttons" do
			before { sign_in user }

			describe "attending an event" do
				before { visit event_path(event) }

				it "should increment the event attendees count" do
					expect do
						click_button "Attend"
					end.to change(event.attendees, :count).by(1)
				end

				it "should increment the user attended_events count" do
					expect do
						click_button "Attend"
					end.to change(user.attended_events, :count).by(1)
				end

				describe "toggling the button" do
					before { click_button "Attend" }
					it { should have_xpath("//input[@value = 'Unattend']") }
				end
			end

			describe "unattending an event" do
				before do
					user.attend!(event)
					visit event_path(event)
				end

				it "should decrement the event attendees count" do
					expect do
						click_button "Unattend"
					end.to change(event.attendees, :count).by(-1)
				end

				it "should decrement the user attended_events count" do
					expect do
						click_button "Unattend"
					end.to change(user.attended_events, :count).by(-1)
				end

				describe "toggling the button" do
					before { click_button "Unattend" }
					it { should have_xpath("//input[@value = 'Attend']") }
				end
			end
		end
	end

	describe "edit page" do
		let(:event) { FactoryGirl.create(:event, user: user) }
		before do
			sign_in user
			visit edit_event_path(event)
		end

		it { should have_title('Edit Event') }
		it { should have_content('Edit Event') }

		describe "with incorrect editing" do
			before do
				fill_in "Event Title", with: " "
				click_button "Update Event"
			end

			it { should have_selector('div.alert.alert-error') }
			it { should have_content('Edit Event') }
		end

		describe "after editing correctly" do
			before do
				fill_in "Venue", with: "Staff Room"
				click_button "Update Event"
			end

			it { should have_selector('div.alert.alert-success') }
			it { should have_content('Event') }
		end
	end

	describe "index page" do
		let(:event) { FactoryGirl.create(:event, user: user) }
		#before { @event = Event.create(event_date: "2014-08-08", event_time: "09:30:00", venue: "Atma",
		#				title: "Meeting", description: "Just a meeting.") }

		describe "without signing in" do
			before { visit events_path }

			it { should have_content('Sign In') }
		end

		describe "with signed in user" do
			before do
				sign_in user
				visit events_path
			end

			it { should have_title('All Events') }
			it { should have_content('All Events') }
			it { should have_selector('ul.events') }
			it { should have_selector('li', text: event.title) }

			describe "Edit & Delete event link" do
				it { should have_link('Edit', edit_event_path(event)) }
				it { should have_link('Delete', event_path(event)) }

				it "should delete the event" do
					expect do
						click_link('Delete', match: :first)
					end.to change(Event, :count).by(-1)
				end

				before { click_link('Edit', edit_event_path(event)) }
				it { should have_content('Edit Event') }
			end
		end
	end

	describe "Attendees page" do
		let(:event) { FactoryGirl.create(:event, user: user) }

		before do
			sign_in user
			user.attend!(event)
			visit attendees_event_path(event)
		end

		it { should have_title('Attendees') }
		it { should have_content('Attendees') }
		it { should have_link(user.name, href: user_path(user)) }
	end
end
