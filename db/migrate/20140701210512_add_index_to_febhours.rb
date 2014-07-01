class AddIndexToFebhours < ActiveRecord::Migration
	def change
		add_index :febhours, [:user_id, :date], unique: true
	end
end
