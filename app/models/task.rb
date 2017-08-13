class Task < ActiveRecord::Base
  belongs_to :tag
  belongs_to :user

  validates :title, presence: true, length: { minimum: 2 }
  validates :goal_time, presence: true
  validates :tag, presence: true

  def tag_attributes=(tag)
    if tag[:tag_id].nil?
      self.tag = Tag.create(title: tag[:title])
    else
      self.tag = Tag.find_by_id(tag[:tag_id])
    end
  end
end
