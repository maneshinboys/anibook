class Book < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  belongs_to :user
   validates :body,
      length: { maximum: 200}
end
