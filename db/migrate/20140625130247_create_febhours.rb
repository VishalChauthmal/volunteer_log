class CreateFebhours < ActiveRecord::Migration
  def change
    create_table :febhours do |t|
      t.integer :user_id
      t.date :date
      t.float :numhours

      t.timestamps
    end
  end
end
