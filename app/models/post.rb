class Post < ApplicationRecord
  belongs_to :user

  validates :sex, presence: true

  validates :title, presence: true
  validates :event_date, presence: true
  validates :venue, presence: true
  validates :event_start_time, presence: true
  validates :event_end_time, presence: true
  validates :posting_start_time, presence: true
  validates :posting_end_time, presence: true
  validates :address, presence: true
  validates :recruitment_numbers, presence: true, numericality: true
  validates :content, presence: true
  validates :price, presence: true, numericality: true
  validates :category, presence: true

  has_one_attached :image

  has_many :orders, dependent: :destroy
end
