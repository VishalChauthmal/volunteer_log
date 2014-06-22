class Org < ActiveRecord::Base

	has_many :users

	validates :org_name, presence: true, uniqueness: { case_sensitive: false }

	# Not sure if this is needed - before_save { self.org_name = org_name.upcase }
end
