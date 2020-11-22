class Photo < ApplicationRecord
  has_one_attached :image_file
  belongs_to :user
  validates :title, presence: true
  validates :title, length: { maximum: 30 }
  validates :image_file, presence: true
end
