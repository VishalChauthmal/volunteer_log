require 'spec_helper'

describe Dechour do

	let(:user) { FactoryGirl.create(:user) }
	before { @dechour = user.dechours.build(date: Date.parse("2015-12-05"), numhours: 5.33) }

	subject { @dechour }

	it { should respond_to(:user_id) }
	it { should respond_to(:date) }
	it { should respond_to(:numhours) }
	it { should respond_to(:user) }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @dechour.user_id = nil }
		it { should_not be_valid }
	end

	describe "when date is not present" do
		before { @dechour.date = nil }
		it { should_not be_valid }
	end

	describe "when numhours is not present" do
		before { @dechour.numhours = nil }
		it { should_not be_valid }
	end

	describe "when the month is not Dec" do
		before { @dechour.date = Date.parse("2015-01-05") }
		#Commented as it's taken care of in controller and not in model: it { should_not be_valid }
	end

	describe "when the user has already submitted the dechour for that date" do
		before do
			@dechour_2 = @dechour.dup
			@dechour_2.save
		end
		#Commented as it's taken care of in controller and not in model: it { should_not be_valid }
	end

	describe "when other user submits the dechour for the same date" do
		let(:user_2) { FactoryGirl.create(:user, email: "user_2@atmavol.com") }
		before do
			@dechour_2 = user_2.dechours.build(date:@dechour.date, numhours: 5.33)
			@dechour_2.save
		end
		it { should be_valid }
	end
end
