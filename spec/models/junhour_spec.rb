require 'spec_helper'

describe Junhour do

	let(:user) { FactoryGirl.create(:user) }
	before { @junhour = user.junhours.build(date: Date.parse("2015-06-05"), numhours: 5.33) }

	subject { @junhour }

	it { should respond_to(:user_id) }
	it { should respond_to(:date) }
	it { should respond_to(:numhours) }
	it { should respond_to(:user) }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @junhour.user_id = nil }
		it { should_not be_valid }
	end

	describe "when date is not present" do
		before { @junhour.date = nil }
		it { should_not be_valid }
	end

	describe "when numhours is not present" do
		before { @junhour.numhours = nil }
		it { should_not be_valid }
	end

	describe "when the month is not Jun" do
		before { @junhour.date = Date.parse("2015-01-05") }
		#Commented as it's taken care of in controller and not in model: it { should_not be_valid }
	end

	describe "when the user has already submitted the junhour for that date" do
		before do
			@junhour_2 = @junhour.dup
			@junhour_2.save
		end
		#Commented as it's taken care of in controller and not in model: it { should_not be_valid }
	end

	describe "when other user submits the junhour for the same date" do
		let(:user_2) { FactoryGirl.create(:user, email: "user_2@atmavol.com") }
		before do
			@junhour_2 = user_2.junhours.build(date:@junhour.date, numhours: 5.33)
			@junhour_2.save
		end
		it { should be_valid }
	end
end
