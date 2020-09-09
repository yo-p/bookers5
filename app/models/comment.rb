class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :content, presence: true
  validates :content, length: { maximum: 140 }
end
