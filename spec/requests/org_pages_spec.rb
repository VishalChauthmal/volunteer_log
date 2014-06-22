require 'spec_helper'

describe "Org Pages" do
	subject { page }

	describe "show page" do
		let(:org) { FactoryGirl.create(:org) }

		before do
			visit org_path(org)
		end

		it { should have_title(org.org_name) }
		it { should have_content(org.org_name) }
	end

	describe "new page" do
		before { visit new_org_path }

		it { should have_title('New Organization') }
		it { should have_content('New Organization') }
	end
end
