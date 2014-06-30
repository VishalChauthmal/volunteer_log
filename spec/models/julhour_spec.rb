require 'spec_helper'

describe Julhour do

	let(:user) { FactoryGirl.create(:user) }
	before { @julhour = user.julhours.build(date: Date.parse("2015-07-05"), numhours: 5.33) }

	subject { @julhour }

	it { should respond_to(:user_id) }
	it { should respond_to(:date) }
	it { should respond_to(:numhours) }
	it { should respond_to(:user) }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @julhour.user_id = nil }
		it { should_not be_valid }
	end

	describe "when date is not present" do
		before { @julhour.date = nil }
		it { should_not be_valid }
	end

	describe "when numhours is not present" do
		before { @julhour.numhours = nil }
		it { should_not be_valid }
	end

	describe "when the month is not Jul" do
		before { @julhour.date = Date.parse("2015-01-05") }
		#Commented as it's taken care of in controller and not in model: it { should_not be_valid }
	end

	describe "when the user has already submitted the julhour for that date" do
		before do
			@julhour_2 = @julhour.dup
			@julhour_2.save
		end
		#Commented as it's taken care of in controller and not in model: it { should_not be_valid }
	end

	describe "when other user submits the julhour for the same date" do
		let(:user_2) { FactoryGirl.create(:user, email: "user_2@atmavol.com") }
		before do
			@julhour_2 = user_2.julhours.build(date:@julhour.date, numhours: 5.33)
			@julhour_2.save
		end
		it { should be_valid }
	end
end
