class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :kid_id
      t.date :date
      t.string :type
      t.integer :amount
      t.string :description

      t.timestamps
    end
  end
end
