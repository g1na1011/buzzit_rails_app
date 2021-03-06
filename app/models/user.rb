class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes, as: :voteable

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, format: { with: /\A.*(?=.{6,})(?=.*[A-Za-z])(?=.*[\d]).*\z/, message: 'must be at least 6 characters long, containing an alphabet and an integer.' }

  before_save :generate_slug

  def admin?
    self.role == 'admin'
  end

  def generate_slug
    self.slug = self.username.downcase
  end

  def to_param
    self.slug
  end
end