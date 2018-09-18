class AddS3ToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :food_photo, :string
  end
end
