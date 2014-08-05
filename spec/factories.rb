FactoryGirl.define do

	factory :user do
		name "Example"
		email "vol@atmaexample.com"
		password "foobar"
		password_confirmation "foobar"
		start_date "2012-12-25"
#	  	sequence(:org_id) { |n| "#{n}" }

#		org
	end

	factory :org do
		sequence(:org_name) { |n| "Org #{n}" }
	end

	factory :event do
		event_date "2014-09-05"
		event_time "10:15:00"
		venue "Atma Office"
		title "Vol Professional Meet"
		description "Something"
		user #Could be asking for trouble with tests
	end
end