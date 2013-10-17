class User < ActiveRecord::Base
  has_many :posts, foreign_key: :user_id
  has_many :comments, foreign_key: :user_id

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, format: { with: /\A.*(?=.{6,})(?=.*[A-Za-z])(?=.*[\d]).*\z/, message: 'must be at least 6 characters long, containing an alphabet and an integer.' }
end