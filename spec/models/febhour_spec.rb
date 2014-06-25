require 'spec_helper'

describe Febhour do

	let(:user) { FactoryGirl.create(:user) }
	before { @febhour = user.febhours.build(date: Date.parse("2015-02-05"), numhours: 5.33) }

	subject { @febhour }

	it { should respond_to(:user_id) }
	it { should respond_to(:date) }
	it { should respond_to(:numhours) }
	it { should respond_to(:user) }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @febhour.user_id = nil }
		it { should_not be_valid }
	end

	describe "when date is not present" do
		before { @febhour.date = nil }
		it { should_not be_valid }
	end

	describe "when numhours is not present" do
		before { @febhour.numhours = nil }
		it { should_not be_valid }
	end

	describe "when the month is not Feb" do
		before { @febhour.date = Date.parse("2015-03-05") }
		#Commented as it's taken care of in controller and not in model: it { should_not be_valid }
	end

	describe "when the user has already submitted the febhour for that date" do
		before do
			@febhour_2 = @febhour.dup
			@febhour_2.save
		end
		it { should_not be_valid }
	end

	describe "when other user submits the febhour for the same date" do
		let(:user_2) { FactoryGirl.create(:user, email: "user_2@atmavol.com") }
		before do
			@febhour_2 = user_2.febhours.build(date:@febhour.date, numhours: 5.33)
			@febhour_2.save
		end
		it { should be_valid }
	end
end
