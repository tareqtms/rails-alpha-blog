class Article < ActiveRecord::Base
  belongs_to :user
  before_validation {self.user = User.last}
  validates :title, presence: true, length: {minimum: 3, maximum: 100}
  validates :description, presence: true, length: {minimum: 10, maximum: 500}
end