class LessonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
    # if @user.has_role? :admin
    #   scope.all
    # else
    #   scope.where.not(content: "")
    # end
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
    @user.has_role?(:admin) #|| @record.course.user_id == @user.id
  end

  def create?
    @user.has_role?(:admin) #|| @record.course.user_id == @user.id
  end

  def destroy?
    @user.has_role?(:admin) || @record.course.user_id == @user.id
  end
end
