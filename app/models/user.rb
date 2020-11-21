class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true,
                    format: /\A[-a-z0-9_+.]+@([-a-z0-9]+\.)+[a-z0-9]{2,}\z/i
  validates :email, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
