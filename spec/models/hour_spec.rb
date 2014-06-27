require 'spec_helper'

describe Hour do

	let(:user) { FactoryGirl.create(:user) }
	before { @hour = user.hours.build(date: Date.parse("2015-02-05"), numhours: 5.33) }

	subject { @hour }

	it { should respond_to(:user_id) }
	it { should respond_to(:date) }
	it { should respond_to(:numhours) }
	it { should respond_to(:user) }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @hour.user_id = nil }
		it { should_not be_valid }
	end

	describe "when date is not present" do
		before { @hour.date = nil }
		it { should_not be_valid }
	end

	describe "when numhours is not present" do
		before { @hour.numhours = nil }
		it { should_not be_valid }
	end

	describe "when the user has already submitted the hour for that date" do
		before do
			@hour_2 = @hour.dup
			@hour_2.save
		end
		it { should_not be_valid }
	end

	# Perhaps not needed as it's deleted right after saving. Checking in months' tables
	# if a particular date is already recorded should be enough.
	describe "when other user submits the hour for the same date" do
		let(:user_2) { FactoryGirl.create(:user, email: "user_2@atmavol.com") }
		before do
			@hour_2 = user_2.hours.build(date:@hour.date, numhours: 5.33)
			@hour_2.save
		end
		it { should be_valid }
	end
end
