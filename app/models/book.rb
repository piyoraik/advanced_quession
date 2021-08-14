# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(word)
    if word
      Book.where('title LIKE(?)', "%#{word}%").or(Book.where('body LIKE(?)', "%#{word}%")).includes(:user)
    else
      Book.all.includes(:user)
    end
  end
end
