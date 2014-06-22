require 'spec_helper'

describe Org do

	let(:org) { Org.new(org_name: "Avanti Fellows") }

	subject { org }

	it { should respond_to(:org_name) }
	it { should respond_to(:users) }

	it { should be_valid }

	describe "when Org Name is blank" do
		before { org.org_name = " " }
		it { should_not be_valid }
	end

	describe "when 2 Orgs have the same Org Name" do
		before do
			org_with_same_org_name = org.dup
			org_with_same_org_name.org_name = org.org_name.downcase
			org_with_same_org_name.save
		end

		it { should_not be_valid }
	end
end
