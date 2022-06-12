class Post < ApplicationRecord
  belongs_to :user
  # has_many :comments, class_name: "post", foreign_key: "post_id"

  # set the default at which information was pulled from the database
  # -> { } this is a proc (procedure). A procedure is a function without name. Rails will evaluate the statement within the proc
  default_scope -> { order(created_at: :desc) }

  validates :user, presence: true
  validates :description, presence: true, length: { maximum: 140 }
  # validates :vote, numericality: { only_integer: true }
  mount_uploader :picture, PictureUploader
  validate :picture_size

  def picture_size
    errors.add(:picture, "should be less than 5MB") if picture.size > 5.megabytes
  end
end
