class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :name, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  attachment :profile_image 

  has_many :books, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_book, through: :likes, source: :book
  has_many :comments, dependent: :destroy

  def already_liked?(book)
    self.likes.exists?(book_id: book.id)
  end
end
