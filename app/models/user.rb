class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation
  attr_accessible :name, :email, :password, :password_confirmation

  validates :name,     presence: true
  validates :email,    presence: true, uniqueness: true
  
  validates :password, presence: true, 
                       confirmation: true, 
                       length: { in: 6..64 },
                       if: :validate_password?

  before_save :encrypt_password
  before_save :generate_api_token, on: :create

  def generate_api_token(len=16)
    self.api_token = SecureRandom.hex(len)
  end

  def encrypt_password
    if password.present?
      self.password_salt    = BCrypt::Engine.generate_salt
      self.crypted_password = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)

    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def validate_password?
    new_record? || password.present?
  end
end