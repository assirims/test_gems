class Lesson < ApplicationRecord
  belongs_to :course
  validates :title, :content, :course, presence: true

  has_rich_text :content

  extend FriendlyId
  friendly_id :title, use: :slugged

  def self.ransackable_attributes(auth_object = nil)
    ["content", "course_id", "created_at", "id", "slug", "title", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["course"]
  end

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  def to_s
    title
  end
end
