class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: false
  validates :password, presence: true

end
