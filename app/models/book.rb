# frozen_string_literal: true

class Book < ApplicationRecord
  # アソシエーション
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # バリデーション
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  # スコープ
  ## 当日の投稿
  scope :created_today, -> { where(created_at: Time.current.all_day).pluck(:id) }
  ## n日前の投稿
  scope :created_day_ago, -> (day) { where(created_at: Time.zone.now.ago((day).days)).pluck(:id) }

  # メソッド
  ## いいね判定
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  ## 検索
  def self.search(word)
    if word
      Book.where('title LIKE(?)', "%#{word}%").or(Book.where('body LIKE(?)', "%#{word}%")).includes(:user)
    else
      Book.all.includes(:user)
    end
  end

  ## 投稿比
  def self.posted_ratio(today, yesterday)
    "#{((today.to_i / yesterday.to_i) * 100).round}%"
  rescue StandardError
    "前日(週)の投稿が0のため計算できません"
  end
end
