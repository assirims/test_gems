class EnrollmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    @user.has_role?(:admin)
  end

  def edit?
    @record.user_id == @user.id || @user.has_role?(:admin)
  end

  def update?
    @record.user_id == @user.id || @user.has_role?(:admin)
  end

  def destroy?
    @record.user_id == @user.id || @user.has_role?(:admin)
  end

  def certificate?
    #course has as many lessons as the user has viewed for this course
    @record.course.lessons_count == @record.course.user_lessons.where(user: @record.user).count && @record.course.lessons_count > 0
  end
end
