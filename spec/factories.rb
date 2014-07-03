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
end