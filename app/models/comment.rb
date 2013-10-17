class Comment < ActiveRecord::Base
  belongs_to :creator, foreign_key: :user_id, class_name: :User
  belongs_to :post, foreign_key: :post_id

  validates :body, presence: true
end