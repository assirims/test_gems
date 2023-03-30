class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :user, :course, presence: true

  validates_uniqueness_of :user_id, scope: :course_id # one user can enroll only once to the same course
  validates_uniqueness_of :course_id, scope: :user_id # one course can have only one enrollment from the same user

  validate :cannot_enroll_to_own_course # user cannot enroll to his own course if course.user == current_user.id

  validates_presence_of :rating, if: :review?
  validates_presence_of :review, if: :rating?

  def to_s
    user.to_s + "  " + course.to_s
  end

  scope :pending_review, -> { where(rating: [0, nil, ""], review: [0, nil, ""]) }

  extend FriendlyId
  friendly_id :to_s, use: :slugged

  def self.ransackable_attributes(auth_object = nil)
    ["course_id", "created_at", "id", "price", "rating", "review", "slug", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["course", "user"]
  end

  protected
  def cannot_enroll_to_own_course
    if self.new_record? && self.user_id.present? && self.course_id.present? && user_id == course.user_id
      errors.add(:base, "You cannot enroll to your own course")
    end
  end
end
