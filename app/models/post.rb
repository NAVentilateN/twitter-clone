class Post < ApplicationRecord
  belongs_to :user
  # has_many :comments, class_name: "post", foreign_key: "post_id"

  validates :user, presence: true
  validates :description, presence: true, length: { maximum: 140 }
  # validates :vote, numericality: { only_integer: true }
end
