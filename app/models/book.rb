class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :profile_image
  
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  validates :user_id, presence: true
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end