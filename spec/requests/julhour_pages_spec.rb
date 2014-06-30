require 'spec_helper'

describe "Julhour Pages" do

	let(:user) { FactoryGirl.create(:user) }
	subject { page }

	describe "new" do

		describe "without user signing in" do
			before { visit new_julhour_path }

			it { should have_link('Sign In') }
			it { should have_content('Please sign in') }
			it { should_not have_content('Fill In Your Log') }
		end

		describe "with user signing in" do
			before do
				sign_in user
				visit new_julhour_path
			end

			it { should have_title('New Log Entry') }
			it { should have_content('Fill In Your Log') }
			it { should have_link('Sign Out') }

			describe "with invalid julhour information" do
				before { click_button "Submit" }

				it { should have_selector('div.alert.alert-error') }
				it { should have_content('Fill In Your Log') }
			end

			describe "with valid julhour information" do
				before do
					fill_in "Date", with: "2015-07-05"
					fill_in "Number of Hours", with: "5.33"
					click_button "Submit"
				end

				it { should have_selector('div.alert.alert-success') }
				it { should have_content('All Logs') }

				describe "if submitted twice for the same date" do
					before do
						visit new_julhour_path
						fill_in "Date", with: "2015-07-05"
						fill_in "Number of Hours", with: "6.33"
						click_button "Submit"
					end

					it { should have_content('already submitted') }
				end
			end
		end
	end

	describe "edit" do

		before do
			sign_in user
			@julhour = user.julhours.create(date: "2015-07-01", numhours: 4.67)
			visit edit_julhour_path(@julhour)
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
			it { should have_content('July') }
		end
	end

	describe "index" do

		before do
			sign_in user
			@julhour = user.julhours.create(date: "#{Date.today.strftime("%Y")}-07-06", numhours: 5.25)
			visit julhours_path
		end

		it { should have_title('Logs') }
		it { should have_content('All Logs') }
		it { should have_link('February', href: febhours_path) }
		it { should have_link(@julhour.numhours) }
		it { should have_link('Add') }
		specify { expect(user.julhours.find_by(date: "#{Date.today.strftime("%Y")}-07-07")).to be_nil }

		describe "after clicking 'Add' link" do
			before { click_link('Add', match: :first) }
		
			it { should have_title('New Log Entry') }
			it { should have_content('Fill In Your Log') }
		end

		describe "after clicking on any hour link" do
			before do
				click_link(@julhour.numhours)
				fill_in "Date", with: "2015-07-05"
				fill_in "Number of Hours", with: "5.33"
				click_button "Submit"
			end

			it { should have_selector('div.alert.alert-success') }
			it { should have_content('All Logs') }
		end		
	end
end
