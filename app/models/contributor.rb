class Contributor < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :self_introducetion, presence: true

  has_many :posts, dependent: :destroy
end
