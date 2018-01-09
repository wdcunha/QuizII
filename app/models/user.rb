class User < ApplicationRecord
  has_many :reviews, dependent: :nullify
  has_many :ideas, dependent: :nullify
  before_save   :downcase_email

  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX


  def full_name
    "#{first_name} #{last_name}"
  end

  private
  def downcase_email
    self.email = email.downcase
  end

end
