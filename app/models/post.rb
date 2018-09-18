class Post < ActiveRecord::Base
    mount_uploader :food_photo, S3Uploader
end
