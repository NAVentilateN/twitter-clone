class Friendlist < ApplicationRecord
  belongs_to :user
  has_many :frend, dependent: :destroy
end
