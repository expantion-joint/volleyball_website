class Order < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :number_of_orders, presence: true, numericality: true
  validates :results, numericality: true

  has_one_attached :image

end
