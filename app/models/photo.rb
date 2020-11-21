class Photo < ApplicationRecord
  has_one_attached :image_file
  belongs_to :user
end
