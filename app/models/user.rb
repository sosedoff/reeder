class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation
  attr_accessible :name, :email, :password, :password_confirmation

  validates :name,     presence: true
  validates :email,    presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, if: :new_record?

  before_save :generate_api_token, on: :create

  def generate_api_token(len=16)
    self.api_token = SecureRandom.hex(len)
  end
end