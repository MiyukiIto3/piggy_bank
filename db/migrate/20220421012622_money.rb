class Money < ActiveRecord::Migration[6.1]
  def change
    drop_table :money
  end
end
