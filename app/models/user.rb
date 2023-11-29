class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, presence: true
  validates :birthday, presence: true
  validates :sex, presence: true
  validates :password, presence: true, on: :create

  
  has_many :contributors, dependent: :destroy
  has_many :orders, dependent: :destroy

  # devise（現在のパスワードを入力しなくてもパスワードを更新できるメソッド）
  def update_without_current_password(params)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank? 
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params)
    clean_up_passwords
    result
  end

end
