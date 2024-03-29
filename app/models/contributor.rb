class Contributor < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :self_introduction, presence: true
  validates :club_name1, presence: true

  has_one_attached :image

  has_many :posts, dependent: :destroy
end
