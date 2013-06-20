class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation
  attr_accessible :name, :email, :password, :password_confirmation

  has_many :feeds, dependent: :destroy

  validates :name,     presence: true
  validates :email,    presence: true, uniqueness: true

  validates :password, presence: true, 
                       confirmation: true, 
                       length: { in: 6..64 },
                       if: :validate_password?

  before_save :encrypt_password
  before_save :generate_perishable_token, on: :create
  before_save :generate_api_token, on: :create

  def self.authenticate(email, password)
    user = User.find_by_email(email)

    if user && user.valid_password?(password)
      user
    end
  end

  def valid_password?(password)
    hash = BCrypt::Engine.hash_secret(password, password_salt)
    hash == password_hash
  end

  private

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt(12)
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def validate_password?
    new_record? || password.present?
  end

  def generate_api_token(len=16)
    self.api_token = SecureRandom.hex(len)
  end

  def generate_perishable_token
    token = BCrypt::Engine.generate_salt(12)
    self.perishable_token = Base64.encode64(token).strip
  end
end