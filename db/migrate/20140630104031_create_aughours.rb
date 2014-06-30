class CreateAughours < ActiveRecord::Migration
  def change
    create_table :aughours do |t|
      t.integer :user_id
      t.date :date
      t.float :numhours

      t.timestamps
    end
  end
end
