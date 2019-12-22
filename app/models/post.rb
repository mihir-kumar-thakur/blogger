class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  validates :title, presence: true

  belongs_to :user
  has_many :likes, dependent: :destroy

  has_one_attached :image
  has_rich_text :content

  before_save :update_published_at

  scope :published, -> { where(published: true) }

  private

  def update_published_at
    self.published_at = DateTime.now if published && published_at.blank?
  end
end
