class Post < ActiveRecord::Base
  include Voteable

  belongs_to :creator, foreign_key: :user_id, class_name: :User
  has_many :comments, order: 'created_at'
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true
  validates :url, presence: true
  validates :description, presence: true
  validates :category_ids, presence: true

  before_save :generate_slug

  def generate_slug
    self.slug = self.title.downcase.squeeze(' ').gsub(/[^0-9a-z ]/i, '').gsub(' ', '-')
  end

  def to_param
    self.slug
  end
end