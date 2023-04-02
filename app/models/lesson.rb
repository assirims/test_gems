class Lesson < ApplicationRecord
  belongs_to :course, counter_cache: true
  #Course.find_each { |course| Course.reset_counters(course.id, :lessons) }

  has_many :user_lessons, dependent: :destroy

  validates :title, :content, :course, presence: true

  has_rich_text :content # gem 'trix'

  extend FriendlyId # gem 'friendly_id'
  friendly_id :title, use: :slugged

  def self.ransackable_attributes(auth_object = nil)
    ["content", "course_id", "created_at", "id", "slug", "title", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["course"]
  end

  include PublicActivity::Model # gem 'public_activity'
  tracked owner: Proc.new{ |controller, _model| controller.current_user }

  include RankedModel # gem 'ranked-model'
  ranks :row_order, with_same: :course_id

  def to_s
    title
  end

  def viewed(user)
    self.user_lessons.where(user: user).present?
    # self.user_lessons.where(user.id: [user.id], lesson_id: [self.id]).present?
  end
end
