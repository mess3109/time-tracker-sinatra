class Tag < ActiveRecord::Base
  has_many :tasks
  belongs_to :user

  validates :title, presence: true, length: { minimum: 2 }
end
