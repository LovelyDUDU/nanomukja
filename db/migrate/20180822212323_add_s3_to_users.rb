class AddS3ToUsers < ActiveRecord::Migration
  def change
    add_column :users, :back_photo_addr, :string
    add_column :users, :profile_photo_addr, :string
  end
end
