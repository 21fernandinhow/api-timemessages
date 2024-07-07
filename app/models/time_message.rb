class TimeMessage < ApplicationRecord
  belongs_to :user, foreign_key: :user_email, primary_key: :email
  validates :content, presence: true
  validates :date_to_open, presence: true
  validates :user_email, presence: true
end
