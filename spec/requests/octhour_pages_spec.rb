require 'spec_helper'

describe "Octhour Pages" do

	let(:user) { FactoryGirl.create(:user) }
	subject { page }

	describe "new" do

		describe "without user signing in" do
			before { visit new_octhour_path }

			it { should have_link('Sign In') }
			it { should have_content('Please sign in') }
			it { should_not have_content('Fill In Your Log') }
		end

		describe "with user signing in" do
			before do
				sign_in user
				visit new_octhour_path
			end

			it { should have_title('New Log Entry') }
			it { should have_content('Fill In Your Log') }
			it { should have_link('Sign Out') }

			describe "with invalid octhour information" do
				before { click_button "Submit" }

				it { should have_selector('div.alert.alert-error') }
				it { should have_content('Fill In Your Log') }
			end

			describe "with valid octhour information" do
				before do
					fill_in "Date", with: "2013-10-05"
					fill_in "Number of Hours", with: "5.33"
					click_button "Submit"
				end

				it { should have_selector('div.alert.alert-success') }
				it { should have_content('All Logs') }

				describe "if submitted twice for the same date" do
					before do
						visit new_octhour_path
						fill_in "Date", with: "2013-10-05"
						fill_in "Number of Hours", with: "6.33"
						click_button "Submit"
					end

					it { should have_content('already submitted') }
				end
			end

			describe "with date prior to start_date" do
				before do
					fill_in "Date", with: "2012-10-10"
					fill_in "Number of Hours", with: "5.33"
					click_button "Submit"
				end

				it { should have_content('prior to your joining.') }
			end

			describe "with a date that's in the future" do
				before do
					fill_in "Date", with: Date.parse((Date.today + 1.year).strftime("%Y-10-%d"))
					fill_in "Number of Hours", with: "6.5"
					click_button "Submit"
				end

				it { should have_content('for future dates') }
			end
		end
	end

	describe "edit" do

		before do
			sign_in user
			@octhour = user.octhours.create(date: "2013-10-01", numhours: 4.67)
			visit edit_octhour_path(@octhour)
		end

		it { should have_content('Date') }
		it { should have_content('Number of Hours') }

		describe "after editing" do
			before do
				#Date not changed
				fill_in "Number of Hours", with: 5.33
				click_button "Submit"
			end

			it { should have_selector('div.alert.alert-success') }
			it { should have_content('October') }
		end

		describe "with date prior to start_date" do
			before do
				fill_in "Date", with: "2012-10-10"
				fill_in "Number of Hours", with: "5.33"
				click_button "Submit"
			end

			it { should have_content('prior to your joining.') }
		end

		describe "with a date that's in the future" do
			before do
				fill_in "Date", with: Date.parse((Date.today + 1.year).strftime("%Y-10-%d"))
				fill_in "Number of Hours", with: "6.5"
				click_button "Submit"
			end

			it { should have_content('for future dates') }
		end
	end

	describe "index" do

		before do
			sign_in user
			@octhour = user.octhours.create(date: "#{Date.today.strftime("%Y")}-10-06", numhours: 5.25)
			visit octhours_path
		end

		it { should have_title('Logs') }
		it { should have_content('All Logs') }
		it { should have_link('January', href: janhours_path) }
		it { should have_link(@octhour.numhours) }
		it { should have_link('Add') }
		specify { expect(user.octhours.find_by(date: "#{Date.today.strftime("%Y")}-10-07")).to be_nil }

		describe "after clicking 'Add' link" do
			before { click_link('Add', match: :first) }
		
			it { should have_title('New Log Entry') }
			it { should have_content('Fill In Your Log') }
		end

		describe "after clicking on any hour link" do
			before do
				click_link(@octhour.numhours)
				fill_in "Date", with: "2013-10-05"
				fill_in "Number of Hours", with: "5.33"
				click_button "Submit"
			end

			it { should have_selector('div.alert.alert-success') }
			it { should have_content('All Logs') }
		end			
	end
end
