class Contact < ApplicationRecord

  validates :name, presence: true
  validates :title, presence: true
  validates :email, presence: true
  validates :content, presence: true

end
