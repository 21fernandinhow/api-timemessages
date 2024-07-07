class User < ApplicationRecord
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    has_many :time_messages, foreign_key: :user_email, primary_key: :email
end
