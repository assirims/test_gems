class Course < ApplicationRecord
  validates :title, :short_description, :language, :price, :level, presence: true
  validates :description, presence: true, length: { minimum: 5 }
  has_rich_text :description

  belongs_to :user
  has_many :lessons, dependent: :destroy
  has_many :enrollments

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

  LEVELS = ["Beginner", "Intermediate", "Advanced"]
  def self.levels
    LEVELS.map { |level| level }
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
    ["created_at", "description", "id", "language", "level", "price", "short_description", "slug", "title", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["rich_text_description", "user"]
  end

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  def bought(user)
    self.enrollments.where(user_id: [user.id], course_id: [self.id]).empty?
  end
end
