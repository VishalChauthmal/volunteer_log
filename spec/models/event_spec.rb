require 'spec_helper'

describe Event do

	let(:user) { FactoryGirl.create(:user) }
	let(:event) { FactoryGirl.create(:event, user: user) }
	subject { event }

	it { should respond_to(:event_date) }
	it { should respond_to(:event_time) }
	it { should respond_to(:venue) }
	it { should respond_to(:user_id) }
	it { should respond_to(:title) }
	it { should respond_to(:description) }
	it { should respond_to(:user) }
	it { should respond_to(:reverse_attendances) }
	it { should respond_to(:attendees) }
	
	it { should be_valid }

	describe "when Event Title is not present" do
		before { event.title = " " }

		it { should_not be_valid }
	end

	describe "when event date is not present" do
		before { event.event_date = " " }

		it { should_not be_valid }
	end
end
