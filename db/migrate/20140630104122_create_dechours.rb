class CreateDechours < ActiveRecord::Migration
  def change
    create_table :dechours do |t|
      t.integer :user_id
      t.date :date
      t.float :numhours

      t.timestamps
    end
  end
end
