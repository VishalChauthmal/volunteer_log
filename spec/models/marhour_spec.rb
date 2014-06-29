require 'spec_helper'

describe Marhour do

	let(:user) { FactoryGirl.create(:user) }
	before { @marhour = user.marhours.build(date: Date.parse("2015-03-05"), numhours: 5.33) }

	subject { @marhour }

	it { should respond_to(:user_id) }
	it { should respond_to(:date) }
	it { should respond_to(:numhours) }
	it { should respond_to(:user) }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @marhour.user_id = nil }
		it { should_not be_valid }
	end

	describe "when date is not present" do
		before { @marhour.date = nil }
		it { should_not be_valid }
	end

	describe "when numhours is not present" do
		before { @marhour.numhours = nil }
		it { should_not be_valid }
	end

	describe "when the month is not Mar" do
		before { @marhour.date = Date.parse("2015-06-05") }
		#Commented as it's taken care of in controller and not in model: it { should_not be_valid }
	end

	describe "when the user has already submitted the marhour for that date" do
		before do
			@marhour_2 = @marhour.dup
			@marhour_2.save
		end
		#Commented as it's taken care of in controller and not in model: it { should_not be_valid }
	end

	describe "when other user submits the marhour for the same date" do
		let(:user_2) { FactoryGirl.create(:user, email: "user_2@atmavol.com") }
		before do
			@marhour_2 = user_2.marhours.build(date:@marhour.date, numhours: 5.33)
			@marhour_2.save
		end
		it { should be_valid }
	end
end
