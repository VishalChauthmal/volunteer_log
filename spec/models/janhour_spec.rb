require 'spec_helper'

describe Janhour do

	let(:user) { FactoryGirl.create(:user) }
	before { @janhour = user.janhours.build(date: Date.parse("2015-01-05"), numhours: 5.33) }

	subject { @janhour }

	it { should respond_to(:user_id) }
	it { should respond_to(:date) }
	it { should respond_to(:numhours) }
	it { should respond_to(:user) }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @janhour.user_id = nil }
		it { should_not be_valid }
	end

	describe "when date is not present" do
		before { @janhour.date = nil }
		it { should_not be_valid }
	end

	describe "when numhours is not present" do
		before { @janhour.numhours = nil }
		it { should_not be_valid }
	end

	describe "when the month is not Jan" do
		before { @janhour.date = Date.parse("2015-02-05") }
		#Commented as it's taken care of in controller and not in model: it { should_not be_valid }
	end

	describe "when the user has already submitted the janhour for that date" do
		before do
			@janhour_2 = @janhour.dup
			@janhour_2.save
		end
		it { should_not be_valid }
	end

	describe "when other user submits the janhour for the same date" do
		let(:user_2) { FactoryGirl.create(:user, email: "user_2@atmavol.com") }
		before do
			@janhour_2 = user_2.janhours.build(date:@janhour.date, numhours: 5.33)
			@janhour_2.save
		end
		it { should be_valid }
	end
end
