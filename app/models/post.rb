class Post < ApplicationRecord
  validates :title, presence: true

  belongs_to :user
  has_one_attached :image
end
