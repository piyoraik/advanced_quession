# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_one_attached :image

  # フォローする側
  has_many :follower, class_name: "Frendship", foreign_key: "follower_id", dependent: :destroy
  has_many :follower_user, through: :follower, source: :followed
  # フォローされる側
  has_many :followed, class_name: "Frendship", foreign_key: "followed_id", dependent: :destroy
  has_many :followed_user, through: :followed, source: :follower

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def image_display(size)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/default.png')
      image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
    image.variant(resize: size.to_s)
  end

  def follow(user_id)
    follower.create!(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy!
  end

  def following?(user)
    follower_user.include?(user)
  end
end
