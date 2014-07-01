require 'spec_helper'

describe "User pages" do
	subject { page }

	describe "Profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }

		it { should have_content(user.name) }
		it { should have_title(user.name) }
	end

	describe "Signup page" do
		before { visit signup_path }

		it { should have_content('Sign Up') }
		it { should have_title('Sign Up') }
	end

	describe "Signup" do
		before { visit signup_path }
		let(:submit) { "Create Account" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit}.not_to change(User, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "Name", with: "Example L"
				fill_in "Email", with: "vol@atmaexample.com"
				# Commented & made org_id optional as it has issues with select: fill_in "Organization", with: 1
				fill_in "Password", with: "foobar"
				fill_in "Confirm Password", with: "foobar"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			describe "after saving the user" do
				before { click_button submit }
				let(:user) { User.find_by(email: "vol@atmaexample.com") }

				it { should have_link('Sign Out') }
				it { should have_title(user.name) }
				it { should have_selector('div.alert.alert-success', text: 'Welcome') }
				specify { expect(user).not_to be_admin }
			end
		end

		describe "with valid information with admin email" do
			before do
				fill_in "Name", with: "Example L"
				fill_in "Email", with: "appadmin@atma.org.in"
				# Commented & made org_id optional as it has issues with select: fill_in "Organization", with: 1
				fill_in "Password", with: "foobar"
				fill_in "Confirm Password", with: "foobar"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			describe "after saving the user" do
				before { click_button submit }
				let(:user) { User.find_by(email: "appadmin@atma.org.in") }

				specify { expect(user).to be_admin }
			end
		end
	end

	describe "Edit" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit edit_user_path(user)
		end

		describe "Page" do
			it { should have_content('Edit Your Profile') }
			it { should have_title('Edit Profile') }
		end

		describe "with invalid information" do
			before { click_button "Save Changes" }

			it { should have_content('error') }
		end

		describe "with valid information" do
			let(:new_name) { "New Vol" }
			let(:new_email) { "newvol@atmaexample.com" }
			#let(:new_org_id) { 3 }

			before do
				fill_in "Name", with: new_name
				fill_in "Email", with: new_email
				#Commented & made org_id optional as it has issues with select: fill_in "Organization ID", with: new_org_id
				fill_in "Password", with: user.password
				fill_in "Confirm Password", with: user.password
				click_button "Save Changes"
			end

			it { should have_title(new_name) }
			it { should have_selector('div.alert.alert-success') }
			it { should have_link('Sign Out', href: signout_path) }
			specify { expect(user.reload.name).to eq new_name }
			specify { expect(user.reload.email).to eq new_email }
		end
	end

	describe "Users index" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit users_path
		end

		it { should have_title("All Users") }
		it { should have_content("All Users") }
		it { should have_selector('ul.users') }
		it { should have_selector('li', text: user.name) }

		describe "Delete User links" do
			it { should_not have_link('Delete') }

			describe "as admin user" do
				let(:adminuser) { FactoryGirl.create(:user, email: "adminuser@atmaexample.org") }
				before do
					adminuser.update_attributes(admin: true)
					sign_in adminuser
					visit users_path
				end

				it { should have_link('Delete') }
				it "should delete the user" do
					expect do
						click_link('Delete', match: :first)
					end.to change(User, :count).by(-1)
				end
				it { should_not have_link('Delete', href: user_path(adminuser)) }
			end
		end
	end

	describe "User Logs page" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit logs_path
		end

		it { should have_title('All Logs') }
		it { should have_content('All Logs') }
		it { should have_link('Add') }

		describe "after clicking the 'Add' link" do
			before { click_link('Add', match: :first) }
			it { should have_content('Fill In Your Log') }
			it { should have_title('New Log Entry') }
		end
	end
end
