class User < ApplicationRecord
  has_secure_password
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: EMAIL_REGEX, message: 'Invalid email format' }
  validates :password, presence: true

end
