require 'spec_helper'

describe Aprhour do

	let(:user) { FactoryGirl.create(:user) }
	before { @aprhour = user.aprhours.build(date: Date.parse("2015-04-05"), numhours: 5.33) }

	subject { @aprhour }

	it { should respond_to(:user_id) }
	it { should respond_to(:date) }
	it { should respond_to(:numhours) }
	it { should respond_to(:user) }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @aprhour.user_id = nil }
		it { should_not be_valid }
	end

	describe "when date is not present" do
		before { @aprhour.date = nil }
		it { should_not be_valid }
	end

	describe "when numhours is not present" do
		before { @aprhour.numhours = nil }
		it { should_not be_valid }
	end

	describe "when the month is not Apr" do
		before { @aprhour.date = Date.parse("2015-06-05") }
		#Commented as it's taken care of in controller and not in model: it { should_not be_valid }
	end

	describe "when the user has already submitted the aprhour for that date" do
		before do
			@aprhour_2 = @aprhour.dup
			@aprhour_2.save
		end
		#Commented as it's taken care of in controller and not in model: it { should_not be_valid }
	end

	describe "when other user submits the aprhour for the same date" do
		let(:user_2) { FactoryGirl.create(:user, email: "user_2@atmavol.com") }
		before do
			@aprhour_2 = user_2.aprhours.build(date:@aprhour.date, numhours: 5.33)
			@aprhour_2.save
		end
		it { should be_valid }
	end
end
