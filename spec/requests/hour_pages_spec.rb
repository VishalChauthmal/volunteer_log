require 'spec_helper'

describe "Hour Pages" do

	let(:user) { FactoryGirl.create(:user) }
	subject { page }

	describe "new" do

		describe "without user signing in" do
			before { visit new_hour_path }

			it { should have_link('Sign In') }
			it { should have_content('Please sign in') }
			it { should_not have_content('Fill In Your Log') }
		end

		describe "with user signing in" do
			before do
				sign_in user
				visit new_hour_path
			end

			it { should have_title('New Log Entry') }
			it { should have_content('Fill In Your Log') }
			it { should have_link('Sign Out') }

			describe "with invalid hour information" do
				before { click_button "Submit" }

				it { should have_selector('div.alert.alert-error') }
				it { should have_content('Fill In Your Log') }
			end

			describe "with valid hour information" do
				before do
					fill_in "Date", with: "2013-02-05"
					fill_in "Number of Hours", with: "5.33"
					click_button "Submit"
				end

				it { should have_selector('div.alert.alert-success') }
				it { should have_content('All Logs') }

				describe "if submitted twice for the same date" do
					before do
						visit new_hour_path
						fill_in "Date", with: "2013-02-05"
						fill_in "Number of Hours", with: "5.33"
						click_button "Submit"
					end

					it { should have_content('already submitted') }
					it { should have_content('All Logs') }
				end
			end

			describe "with date prior to start_date" do
				before do
					fill_in "Date", with: "2012-05-10"
					fill_in "Number of Hours", with: "5.33"
					click_button "Submit"
				end

				it { should have_content('prior to your joining.') }
			end

			describe "with a date that's in the future" do
				before do
					fill_in "Date", with: Date.today + 3.days
					fill_in "Number of Hours", with: "6.5"
					click_button "Submit"
				end

				it { should have_content('for future dates') }
			end
		end
	end
end
