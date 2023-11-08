class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :birthday, presence: true
  validates :sex, presence: true
  
  has_many :posts, dependent: :destroy
  has_many :contributors, dependent: :destroy
  has_many :orders, dependent: :destroy
end