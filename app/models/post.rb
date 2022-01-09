class Post < ApplicationRecord
  validates :title, :content, presence: true, length: { minimum: 5, maximum: 200 }
  belongs_to :author
end
