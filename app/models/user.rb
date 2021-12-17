class User < ApplicationRecord
  attr_accessor :password

  validates_presence_of :username
  validates_uniqueness_of :username

  has_many :goals

  before_validation :downcase_username
  before_save :encrypt_password

  private

  def encrypt_password
    return if password.blank?

    self.salt = BCrypt::Engine.generate_salt
    self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
  end

  def downcase_username
    self.username = username.downcase if username.present?
  end
end
