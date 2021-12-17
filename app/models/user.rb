class User < ApplicationRecord
  attr_accessor :password

  validates_presence_of :username
  validates_uniqueness_of :username

  validates_presence_of :password, if: :new_record?

  has_many :goals

  before_validation :downcase_username
  before_save :encrypt_password

  def self.authenticate(username = '', login_password = '')
    return if username.nil? || login_password.nil?

    user = User.find_by(username: username)

    user if user.present? && user.match_password(login_password)
  end

  def match_password(login_password = '')
    encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
  end

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
