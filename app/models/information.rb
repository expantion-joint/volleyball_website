class Information < ApplicationRecord
  
  validates :title, presence: true
  validates :public_or_private, presence: true
  has_one_attached :image

end
