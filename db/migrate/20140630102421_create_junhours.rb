class CreateJunhours < ActiveRecord::Migration
  def change
    create_table :junhours do |t|
      t.integer :user_id
      t.date :date
      t.float :numhours

      t.timestamps
    end
  end
end
