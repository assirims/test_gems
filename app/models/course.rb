class Course < ApplicationRecord
  validates :title, :marketing_description, :language, :price, :level, presence: true
  validates :description, presence: true, length: { minimum: 5 }
  validates :title, uniqueness: true
  validates :marketing_description, length: { maximum: 140 }

  scope :latest, -> { limit(3).order(created_at: :desc) }
  scope :top_rated, -> { limit(3).order(average_rating: :desc, created_at: :desc) }
  scope :popular, -> { limit(3).order(enrollments_count: :desc, created_at: :desc) }
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  scope :approved, -> { where(approved: true) }
  scope :unapproved, -> { where(approved: false) }

  has_rich_text :description

  has_one_attached :avatar
  validates :avatar, presence: false, on: :update
  validates :avatar,
              content_type: ['image/png', 'image/jpg', 'image/jpeg'],
              size: { less_than: 500.kilobytes, message: 'size must be less than 500kb' }

  belongs_to :user, counter_cache: true
  #User.find_each { |user| User.reset_counters(user.id, :courses) }

  has_many :lessons, dependent: :destroy
  has_many :enrollments, dependent: :restrict_with_error
  has_many :user_lessons, through: :lessons
  has_many :course_tags, inverse_of: :course, dependent: :destroy
  has_many :tags, through: :course_tags

  def to_s
    title
  end

  # friendly_id
  extend FriendlyId
  friendly_id :title, use: :slugged

  LANGUAGES = ["English", "Russian", "Polish", "Spanish"]
  def self.languages
    LANGUAGES.map { |language| language }
  end

  LEVELS = ["All levels", "Beginner", "Intermediate", "Advanced"]
  def self.levels
    LEVELS.map { |level| level }
  end

  def calculate_income
    update_column :income, (enrollments.map(&:price).sum)
    user.calculate_course_income
  end

  def update_rating
    if enrollments.any? && enrollments.where.not(rating: nil).any?
      update_column :average_rating, (enrollments.average(:rating).round(2).to_f)
    else
      update_column :average_rating, (0)
    end
  end

  # ransack search attributes
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "language", "level", "price", "marketing_description", "slug", "title", "updated_at", "published", "approved", "average_rating", "enrollments_count", "lessons_count" , "course_tags_tag_name_cont" , "course_tags_tag_id_eq", "tags_count" ]
  end
  def self.ransackable_associations(auth_object = nil)
    ["rich_text_description", "user", "course_tags"]
  end

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, _model| controller.current_user }

  def bought(user)
    self.enrollments.where(user_id: [user.id], course_id: [self.id]).empty?
  end

  def progress(user)
    unless self.lessons_count == 0
      user_lessons.where(user: user).count/self.lessons_count.to_f*100
    end
  end
end
