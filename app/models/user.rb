class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_one_attached :image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def image_display(size)
    unless self.image.attached?
      self.image.attach(io: File.open(Rails.root.join('app','assets','images','default.png')),filename: 'default-image.png', content_type: 'image/png')
    end
    self.image.variant(resize:"#{size}")
  end
end
