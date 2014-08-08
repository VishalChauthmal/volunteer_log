require 'spec_helper'

describe "Org Pages" do
	subject { page }

	describe "show org page" do
		let(:org) { FactoryGirl.create(:org) }

		before { visit org_path(org) }

		it { should have_title(org.org_name) }
		it { should have_content(org.org_name) }
	end

	describe "new org page" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit new_org_path
		end

		it { should have_title('New Organization') }
		it { should have_content('New Organization') }
	end

	describe "edit org page" do
		let(:org) { FactoryGirl.create(:org) }
		let(:user) { FactoryGirl.create(:user) }

		describe "without user signing in " do
			before { visit edit_org_path(org) }

			it { should have_title('Sign In') }
			it { should have_content('Sign In') }
		end

		describe "with user signing in" do
			before do
				sign_in user
				visit edit_org_path(org)
			end

			it { should have_title('Edit Organization') }
			it { should have_content('Edit Organization') }

			describe "without valid org information" do
				before do
					fill_in "Organization Name", with: ""
					click_button "Save Changes"
				end

				it { should have_selector('div.alert.alert-error') }
			end

			describe "with valid org information" do
				before do
					fill_in "Organization Name", with: "New Org Name"
					click_button "Save Changes"
				end

				it { should have_title("New Org Name") }
				it { should have_content("New Org Name") }
				it { should have_selector('div.alert.alert-success') }
				specify { expect(org.reload.org_name).to eq "New Org Name" }
			end
		end
	end

	describe "index page" do
		let(:org) { FactoryGirl.create(:org) }
		let(:user) { FactoryGirl.create(:user) }

		describe "without user signing in " do
			before { visit orgs_path }

			it { should have_title('Sign In') }
			it { should have_content('Sign In') }
		end

		describe "with a signed-in user" do
			before do
				sign_in user
				visit orgs_path
			end

			it { should have_title('All Organizations') }
			it { should have_selector('h2', text: 'All Organizations') }
			it { should have_content(org.org_name) }
		end
	end
end
