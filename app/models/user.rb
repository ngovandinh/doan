class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :tests, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :requests, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.max_name}
  validates :email, presence: true,
    length: {maximum: Settings.max_email},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.mini_password}, allow_nil: true

  has_secure_password

  before_save :downcase_email

  def downcase_email
   self.email = email.downcase
  end
end
