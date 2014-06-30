class CreateNovhours < ActiveRecord::Migration
  def change
    create_table :novhours do |t|
      t.integer :user_id
      t.date :date
      t.float :numhours

      t.timestamps
    end
  end
end
