class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :user, :course, presence: true

  validates_uniqueness_of :user_id, scope: :course_id # one user can enroll only once to the same course
  validates_uniqueness_of :course_id, scope: :user_id # one course can have only one enrollment from the same user

  validate :cannot_enroll_to_own_course # user cannot enroll to his own course if course.user == current_user.id

  def to_s
    user.to_s + "  " + course.to_s
  end

  scope :pending_review, -> { where(rating: [0, nil, ""], review: [0, nil, ""]) }
  
  protected
  def cannot_enroll_to_own_course
    if self.new_record? && self.user_id.present? && self.course_id.present? && user_id == course.user_id
      errors.add(:base, "You cannot enroll to your own course")
    end
  end
end
