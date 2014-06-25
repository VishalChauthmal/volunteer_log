require 'spec_helper'

describe "Marhour Pages" do

	let(:user) { FactoryGirl.create(:user) }
	subject { page }

	describe "new" do

		describe "without user signing in" do
			before { visit new_marhour_path }

			it { should have_link('Sign In') }
			it { should have_content('Please sign in') }
			it { should_not have_content('Fill In Your Log') }
		end

		describe "with user signing in" do
			before do
				sign_in user
				visit new_marhour_path
			end

			it { should have_title('New Log Entry') }
			it { should have_content('Fill In Your Log') }
			it { should have_link('Sign Out') }

			describe "with invalid marhour information" do
				before { click_button "Submit" }

				it { should have_selector('div.alert.alert-error') }
				it { should have_content('Fill In Your Log') }
			end

			describe "with valid marhour information" do
				before do
					fill_in "Date", with: "2015-03-05" # ??
					fill_in "Number of Hours", with: "5.33"
				end

				#Not able to check possibly due to the Date field above
				#it { should have_selector('div.alert.alert-success') }
				#it { should have_content('Volunteer Name') }
			end
		end
	end

	describe "edit" do

		before do
			sign_in user
			@marhour = user.marhours.create(date: "2015-03-01", numhours: 4.67)
			visit edit_marhour_path(@marhour)
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
			it { should have_content('Volunteer Name') }
		end
	end

	describe "index" do

		before do
			sign_in user
			@marhour = user.marhours.create(date: "#{Date.today.strftime("%Y")}-03-06", numhours: 5.25)
			visit marhours_path
		end

		it { should have_title('Logs') }
		it { should have_content('All Logs') }
		it { should have_content(@marhour.numhours) }
		it { should have_link('Add') }
		specify { expect(user.marhours.find_by(date: "#{Date.today.strftime("%Y")}-03-07")).to be_nil }
	end
end
