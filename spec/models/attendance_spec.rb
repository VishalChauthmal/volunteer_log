require 'spec_helper'

describe Attendance do

	let(:attendee) { FactoryGirl.create(:user, email: "attendee@atma.org.in") }
	let(:event) { FactoryGirl.create(:event) }
	let(:attendance) { attendee.attendances.build(event_id: event.id) }

	subject { attendance }

	it { should be_valid }

	describe "attendance methods" do
		it { should respond_to(:attendee) }
		it { should respond_to(:event) }
		its(:attendee) { should eq attendee }
		its(:event) { should eq event }
	end

	describe "when attendee_id is not present" do
		before { attendance.attendee_id = nil }
		it { should_not be_valid }
	end

	describe "when event_id is not present" do
		before { attendance.event_id = nil }
		it { should_not be_valid }
	end
end
