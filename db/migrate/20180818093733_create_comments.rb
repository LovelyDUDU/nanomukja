class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      
      t.string :writer
      t.integer :post_id
      t.text :content, default: ""
      t.float :star_score, default: 0.0
      
      t.timestamps null: false
    end
  end
end
