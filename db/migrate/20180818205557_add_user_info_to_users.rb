class AddUserInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, default: ""
    add_column :users, :birthdate, :string, default: ""
    add_column :users, :email_confirm, :string
    add_column :users, :gender, :string
    add_column :users, :phone, :string, default: ""
    # add_column :users, :profile_photo_addr, :string
    # add_column :users, :back_photo_addr, :string
    add_column :users, :introduce, :string, default: ""
    add_column :users, :star_score, :float ,default: 0.0
    add_column :users, :latitude, :float, default: 0.0
    add_column :users, :longitude, :float, default: 0.0
    
    
    
  end
end
