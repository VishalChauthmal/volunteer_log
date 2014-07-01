class AddIndexToMonhours < ActiveRecord::Migration
	def change
		add_index :janhours, :user_id
		add_index :febhours, :user_id
		add_index :marhours, :user_id
		add_index :aprhours, :user_id
		add_index :mayhours, :user_id
		add_index :junhours, :user_id
		add_index :julhours, :user_id
		add_index :aughours, :user_id
		add_index :sephours, :user_id
		add_index :octhours, :user_id
		add_index :novhours, :user_id
		add_index :dechours, :user_id

		add_index :janhours, :date
		add_index :febhours, :date
		add_index :marhours, :date
		add_index :aprhours, :date
		add_index :mayhours, :date
		add_index :junhours, :date
		add_index :julhours, :date
		add_index :aughours, :date
		add_index :sephours, :date
		add_index :octhours, :date
		add_index :novhours, :date
		add_index :dechours, :date

		add_index :janhours, [:user_id, :date], unique: true
		add_index :febhours, [:user_id, :date], unique: true
		add_index :marhours, [:user_id, :date], unique: true
		add_index :aprhours, [:user_id, :date], unique: true
		add_index :mayhours, [:user_id, :date], unique: true
		add_index :junhours, [:user_id, :date], unique: true
		add_index :julhours, [:user_id, :date], unique: true
		add_index :aughours, [:user_id, :date], unique: true
		add_index :sephours, [:user_id, :date], unique: true
		add_index :octhours, [:user_id, :date], unique: true
		add_index :novhours, [:user_id, :date], unique: true
		add_index :dechours, [:user_id, :date], unique: true
	end
end
