require 'spec_helper'

describe Octhour do

	let(:user) { FactoryGirl.create(:user) }
	before { @octhour = user.octhours.build(date: Date.parse("2015-10-05"), numhours: 5.33) }

	subject { @octhour }

	it { should respond_to(:user_id) }
	it { should respond_to(:date) }
	it { should respond_to(:numhours) }
	it { should respond_to(:user) }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @octhour.user_id = nil }
		it { should_not be_valid }
	end

	describe "when date is not present" do
		before { @octhour.date = nil }
		it { should_not be_valid }
	end

	describe "when numhours is not present" do
		before { @octhour.numhours = nil }
		it { should_not be_valid }
	end

	describe "when the month is not Oct" do
		before { @octhour.date = Date.parse("2015-01-05") }
		#Commented as it's taken care of in controller and not in model: it { should_not be_valid }
	end

	describe "when the user has already submitted the octhour for that date" do
		before do
			@octhour_2 = @octhour.dup
			@octhour_2.save
		end
		#Commented as it's taken care of in controller and not in model: it { should_not be_valid }
	end

	describe "when other user submits the octhour for the same date" do
		let(:user_2) { FactoryGirl.create(:user, email: "user_2@atmavol.com") }
		before do
			@octhour_2 = user_2.octhours.build(date:@octhour.date, numhours: 5.33)
			@octhour_2.save
		end
		it { should be_valid }
	end
end
