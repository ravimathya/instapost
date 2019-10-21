class Post < ApplicationRecord
    mount_uploader :photo, PhotoUploader
    belongs_to :user
    has_many :comment
    validates :photo, :description, :user_id, presence: true
end
