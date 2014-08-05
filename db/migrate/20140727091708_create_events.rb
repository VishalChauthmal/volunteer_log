class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :event_date
      t.time :event_time
      t.string :venue
      t.integer :user_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
