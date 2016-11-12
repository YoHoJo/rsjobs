class Post < ActiveRecord::Base
  belongs_to :user

  default_scope -> {order(created_at: :desc)}
  validates :category, presence: true
  validates :description, presence: true
end
