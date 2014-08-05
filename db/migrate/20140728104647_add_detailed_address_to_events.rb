class AddDetailedAddressToEvents < ActiveRecord::Migration
	def change
		add_column :events, :detailed_address, :text
	end
end
