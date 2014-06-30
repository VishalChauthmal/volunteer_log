require 'spec_helper'

describe Novhour do

	let(:user) { FactoryGirl.create(:user) }
	before { @novhour = user.novhours.build(date: Date.parse("2015-11-05"), numhours: 5.33) }

	subject { @novhour }

	it { should respond_to(:user_id) }
	it { should respond_to(:date) }
	it { should respond_to(:numhours) }
	it { should respond_to(:user) }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @novhour.user_id = nil }
		it { should_not be_valid }
	end

	describe "when date is not present" do
		before { @novhour.date = nil }
		it { should_not be_valid }
	end

	describe "when numhours is not present" do
		before { @novhour.numhours = nil }
		it { should_not be_valid }
	end

	describe "when the month is not Nov" do
		before { @novhour.date = Date.parse("2015-01-05") }
		#Commented as it's taken care of in controller and not in model: it { should_not be_valid }
	end

	describe "when the user has already submitted the novhour for that date" do
		before do
			@novhour_2 = @novhour.dup
			@novhour_2.save
		end
		#Commented as it's taken care of in controller and not in model: it { should_not be_valid }
	end

	describe "when other user submits the novhour for the same date" do
		let(:user_2) { FactoryGirl.create(:user, email: "user_2@atmavol.com") }
		before do
			@novhour_2 = user_2.novhours.build(date:@novhour.date, numhours: 5.33)
			@novhour_2.save
		end
		it { should be_valid }
	end
end
