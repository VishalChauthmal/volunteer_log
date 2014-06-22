class CreateOrgs < ActiveRecord::Migration
  def change
    create_table :orgs do |t|
      t.string :org_name

      t.timestamps
    end
  end
end
