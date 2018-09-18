class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name,         null: false
      t.string :writer,       null: false
      t.integer :total_price, default: 0
      t.integer :people_num, default: 0
      # t.string :food_photo
      t.text :content, default: ""
      t.string :category
      t.float :avg_star_score, default: 0.0
      t.float :lat
      t.float :lng
      t.date :final_date, default: Time.new
      t.integer :total_star, default: 0
      t.integer :comment_cnt, default: 0
      
      t.timestamps null: false
    end
  end
end
