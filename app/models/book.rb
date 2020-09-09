class Book < ApplicationRecord
  belongs_to :user, optional: true

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
end
