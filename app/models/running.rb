class Running < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :comments
end
