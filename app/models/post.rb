class Post < ApplicationRecord
  validates :title, :content, presence: true, length: { minimum: 5, maximum: 200 }
  belongs_to :author
  has_many :comments, dependent: :destroy
end
