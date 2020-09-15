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

  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

# いいね機能
  def already_liked?(book)
    self.likes.exists?(book_id: book.id)
  end

# フォロー機能
  def follow(other_uer)
    unless self == other_uer
      self.relationships.find_or_create_by(follow_id: other_uer.id)
    end
  end

  def unfollow(other_uer)
    relationship = self.relationships.find_by(follow_id: other_uer.id)
    relationship.destroy if relationship
  end

  def following?(other_uer)
    self.followings.include?(other_uer)
  end


end
