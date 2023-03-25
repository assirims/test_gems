class Lesson < ApplicationRecord
  belongs_to :course
  validates :title, :content, :course, presence: true

  extend FriendlyId
  friendly_id :title, use: :slugged

  def self.ransackable_attributes(auth_object = nil)
    ["content", "course_id", "created_at", "id", "slug", "title", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["course"]
  end
end
