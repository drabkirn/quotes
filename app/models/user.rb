class User < ApplicationRecord

  after_initialize do |user|
    user.quotes_token = SecureRandom.hex(15) if user.quotes_token.empty?
  end

  validates :quotes_token, presence: true, length: { is: 30 }, uniqueness: { case_sensitive: true }
  validates :quotes_api_count, presence: true
end
