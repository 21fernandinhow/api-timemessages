class TimeMessage < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
  validates :date_to_open, presence: true
  validates :user_id, presence: true
end
