class User < ApplicationRecord
  has_many :courses, dependent: :nullify
  has_many :enrollments, dependent: :nullify
  has_many :user_lessons, dependent: :nullify
  has_many :comments, dependent: :nullify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable, :confirmable

  # rolify must be before after_create assign_default_role
  # to avoid assigning roles twice
  rolify
  after_create :assign_default_role
  def assign_default_role
    if User.count == 1
      self.add_role(:admin) if self.roles.blank?
      self.add_role(:teacher)
      self.add_role(:student)
    else
      self.add_role(:student) if self.roles.blank?
      self.add_role(:teacher) #if you want any user to be able to create own courses
    end
  end

  # friendly_id
  extend FriendlyId
  friendly_id :email, use: :slugged

  def online?
    updated_at > 2.minutes.ago
  end

  def to_s
    email
  end

  def username
    self.email.split(/@/).first
  end

  def self.ransackable_attributes(auth_object = nil)
    ["confirmation_sent_at", "confirmation_token", "confirmed_at", "created_at", "current_sign_in_at", "current_sign_in_ip", "email", "encrypted_password", "id", "last_sign_in_at", "last_sign_in_ip", "remember_created_at", "reset_password_sent_at", "user_lessons_count", "comments_count", "reset_password_token", "sign_in_count", "unconfirmed_email", "updated_at", "courses_count", "enrollments_count", "user_lessons_count"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["courses"]
  end

  def buy_course(course)
    self.enrollments.create(course: course, price: course.price)
  end

  def view_lesson(lesson)
    user_lesson = self.user_lessons.where(lesson: lesson)
    if user_lesson.any?
      user_lesson.first.increment!(:impressions)
    else
      self.user_lessons.create(lesson: lesson)
    end
  end

  # works with simple_form_for only
  validate :must_have_a_role, on: :update
  private
  def must_have_a_role
    errors.add(:roles, 'must have at least one role') unless roles.any?
  end

end
