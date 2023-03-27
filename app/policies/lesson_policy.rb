class LessonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    @user.has_role?(:admin) || @record.course.user_id == @user.id
  end

  def edit?
    @user.has_role?(:admin) || @record.course.user_id == @user.id
  end

  def update?
    @user.has_role?(:admin) || @record.course.user_id == @user.id
  end

  def new?
    @user.has_role?(:admin) || @user.has_role?(:teacher)
    # @record.course.user_id == @user.id
    # @courses.id == 1
    # @user.id == 1
    # user_author
  end

  def create?
    @user.has_role?(:admin) #|| @record.course.user_id == @user.id
  end

  def destroy?
    @user.has_role?(:admin) || @record.course.user_id == @user.id
  end
end
