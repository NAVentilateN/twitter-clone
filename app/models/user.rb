class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, length: { maximum: 200 }
  validates :username, presence: true, length: { maximum: 50 }

  has_many :posts
  has_one :friendlist
  has_many :friends, through: :friendlist
end
