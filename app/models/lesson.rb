class Lesson < ApplicationRecord
  belongs_to :course, counter_cache: true
  #Course.find_each { |course| Course.reset_counters(course.id, :lessons) }

  has_many :user_lessons, dependent: :destroy

  validates :title, :content, :course, presence: true
  validates :title, length: { minimum: 1, maximum: 70 }
  validates_uniqueness_of :title, scope: :course_id

  has_rich_text :content # gem 'trix'

  has_one_attached :video
  has_one_attached :video_thumbnail
  validates :video,
    content_type: [:mp4],
    size: { less_than: 50.megabytes, message: "should be less than 50MB" }
  validates :video_thumbnail,
    content_type: [:png, :jpg, :jpeg],
    size: { less_than: 500.kilobytes, message: "should be less than 500KB" }

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
  ranks :position, with_same: :course_id

  def to_s
    title
  end

  def viewed(user)
    self.user_lessons.where(user: user).present?
    # self.user_lessons.where(user.id: [user.id], lesson_id: [self.id]).present?
  end

  def prev
    course.lessons.where("position < ?", position).order(:position).last
  end

  def next
    course.lessons.where("position > ?", position).order(:position).first
  end
end
