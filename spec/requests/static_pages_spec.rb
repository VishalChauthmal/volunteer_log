require 'spec_helper'

describe "Static pages" do
	
	describe "Home page" do
	
		it "should have content 'Home' " do
			visit '/static_pages/home'
			expect(page).to have_content('Home')
		end
	end

	describe "Help page" do

		it "should have content 'Help' " do
			visit '/static_pages/help'
			expect(page).to have_content('Help')
		end
	end

	describe "should have content 'About' " do

		it "should have content 'About' " do
			visit '/static_pages/about'
			expect(page).to have_content('About')
		end
	end

	describe "should have content 'Contact' " do

		it "should have content 'Contact' " do
			visit '/static_pages/contact'
			expect(page).to have_content('Contact')
		end
	end
end
