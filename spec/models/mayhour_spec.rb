require 'spec_helper'

describe Mayhour do

	let(:user) { FactoryGirl.create(:user) }
	before { @mayhour = user.mayhours.build(date: Date.parse("2015-05-05"), numhours: 5.33) }

	subject { @mayhour }

	it { should respond_to(:user_id) }
	it { should respond_to(:date) }
	it { should respond_to(:numhours) }
	it { should respond_to(:user) }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @mayhour.user_id = nil }
		it { should_not be_valid }
	end

	describe "when date is not present" do
		before { @mayhour.date = nil }
		it { should_not be_valid }
	end

	describe "when numhours is not present" do
		before { @mayhour.numhours = nil }
		it { should_not be_valid }
	end

	describe "when the month is not May" do
		before { @mayhour.date = Date.parse("2015-06-05") }
		#Commented as it's taken care of in controller and not in model: it { should_not be_valid }
	end

	describe "when the user has already submitted the mayhour for that date" do
		before do
			@mayhour_2 = @mayhour.dup
			@mayhour_2.save
		end
		#Commented as it's taken care of in controller and not in model: it { should_not be_valid }
	end

	describe "when other user submits the mayhour for the same date" do
		let(:user_2) { FactoryGirl.create(:user, email: "user_2@atmavol.com") }
		before do
			@mayhour_2 = user_2.mayhours.build(date:@mayhour.date, numhours: 5.33)
			@mayhour_2.save
		end
		it { should be_valid }
	end
end
