class Comment < ApplicationRecord

  validates :content, presence: { message: "内容不能为空" }

  belongs_to :user
  belongs_to :product

end
