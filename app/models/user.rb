class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, presence: true
  validates :birthday, presence: true
  validates :sex, presence: true

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: "は半角英数混合で入力してください" }, on: :create
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は半角英数混合で入力してください' }, allow_blank: true, on: :update
  
  has_many :contributors, dependent: :destroy
  has_many :orders, dependent: :destroy

  # devise（現在のパスワードを入力しなくてもパスワードを更新できるメソッド）
  def update_without_current_password(params)

    if params[:password].blank? && params[:password_confirmation].blank? 
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params)
    clean_up_passwords
    result
  end

end
