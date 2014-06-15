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
				fill_in "Password", with: "foobar"
				fill_in "Confirm Password", with: "foobar"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end
		end
	end
end