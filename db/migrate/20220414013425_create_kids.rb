class CreateKids < ActiveRecord::Migration[6.1]
  def change
    create_table :kids do |t|
      t.string :name
      t.integer :sex
      t.string :image
      t.string :target
      t.integer :target_amount
      t.integer :user_id

      t.timestamps
    end
  end
end
