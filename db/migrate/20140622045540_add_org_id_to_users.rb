class AddOrgIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :org_id, :integer
  end
end
