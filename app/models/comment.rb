class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user

  validates_presence_of :content, message: 'can not be blank'
end
