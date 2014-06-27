require 'spec_helper'

describe "Static pages" do

	subject { page }

	describe "Home page" do
		before { visit root_path }

		it { should have_link('Home') }
		it { should have_title(full_title('')) }
		it { should_not have_title('| Home') }
		it { should have_content('Welcome') }

		describe "after siging in" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				sign_in user
				visit root_path
			end

			it { should_not have_link('Sign Up', href: signup_path) }
			it { should have_content('Fill In Your Log Below') }
			it { should have_link('January', href: janhours_path) }
			it { should have_link('February', href: febhours_path) }
		end
	end

	describe "Help page" do
		before { visit help_path }

		it { should have_content('Help') }
		it { should have_title(full_title('Help')) }
	end

	describe "should have content 'About' " do
		before { visit about_path }

		it { should have_content('About') }
		it { should have_title(full_title('About')) }
	end

	describe "should have content 'Contact' " do
		before { visit contact_path }

		it { should have_content('Contact') }
		it { should have_title(full_title('Contact')) }
	end
end
