class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|

      t.string :following_id
      t.string :follower_id

      
      t.timestamps null: false
    end
  end
end
