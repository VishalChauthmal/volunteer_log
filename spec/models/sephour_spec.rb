require 'spec_helper'

describe Sephour do

	let(:user) { FactoryGirl.create(:user) }
	before { @sephour = user.sephours.build(date: Date.parse("2015-09-05"), numhours: 5.33) }

	subject { @sephour }

	it { should respond_to(:user_id) }
	it { should respond_to(:date) }
	it { should respond_to(:numhours) }
	it { should respond_to(:user) }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @sephour.user_id = nil }
		it { should_not be_valid }
	end

	describe "when date is not present" do
		before { @sephour.date = nil }
		it { should_not be_valid }
	end

	describe "when numhours is not present" do
		before { @sephour.numhours = nil }
		it { should_not be_valid }
	end

	describe "when the month is not Sep" do
		before { @sephour.date = Date.parse("2015-01-05") }
		#Commented as it's taken care of in controller and not in model: it { should_not be_valid }
	end

	describe "when the user has already submitted the sephour for that date" do
		before do
			@sephour_2 = @sephour.dup
			@sephour_2.save
		end
		#Commented as it's taken care of in controller and not in model: it { should_not be_valid }
	end

	describe "when other user submits the sephour for the same date" do
		let(:user_2) { FactoryGirl.create(:user, email: "user_2@atmavol.com") }
		before do
			@sephour_2 = user_2.sephours.build(date:@sephour.date, numhours: 5.33)
			@sephour_2.save
		end
		it { should be_valid }
	end
end
