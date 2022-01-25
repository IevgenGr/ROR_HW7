class Comment < ApplicationRecord
  belongs_to :author
  belongs_to :post
  validates :body, presence: true
  enum status: %i[unpublished published]
  scope :published, -> { where(status: :published) }
  scope :unpublished, -> { where(status: :unpublished) }
end
