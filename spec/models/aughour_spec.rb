require 'spec_helper'

describe Aughour do

	let(:user) { FactoryGirl.create(:user) }
	before { @aughour = user.aughours.build(date: Date.parse("2015-08-05"), numhours: 5.33) }

	subject { @aughour }

	it { should respond_to(:user_id) }
	it { should respond_to(:date) }
	it { should respond_to(:numhours) }
	it { should respond_to(:user) }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @aughour.user_id = nil }
		it { should_not be_valid }
	end

	describe "when date is not present" do
		before { @aughour.date = nil }
		it { should_not be_valid }
	end

	describe "when numhours is not present" do
		before { @aughour.numhours = nil }
		it { should_not be_valid }
	end

	describe "when the month is not Aug" do
		before { @aughour.date = Date.parse("2015-01-05") }
		#Commented as it's taken care of in controller and not in model: it { should_not be_valid }
	end

	describe "when the user has already submitted the Aughour for that date" do
		before do
			@aughour_2 = @aughour.dup
			@aughour_2.save
		end
		#Commented as it's taken care of in controller and not in model: it { should_not be_valid }
	end

	describe "when other user submits the aughour for the same date" do
		let(:user_2) { FactoryGirl.create(:user, email: "user_2@atmavol.com") }
		before do
			@aughour_2 = user_2.aughours.build(date:@aughour.date, numhours: 5.33)
			@aughour_2.save
		end
		it { should be_valid }
	end
end
