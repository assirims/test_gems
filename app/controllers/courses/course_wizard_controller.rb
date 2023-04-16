class Courses::CourseWizardController < ApplicationController
  include Wicked::Wizard
  before_action :set_progress, only: [:show, :update]
  before_action :set_course, only: [:show, :update, :finish_wizard_path]
  before_action :authorize!, only: [:show, :update, :finish_wizard_path]

  steps :basic_info, :details, :publish

  def show
    case step
    when :basic_info
    when :details
      @tags = Tag.all
    when :publish
    end
    render_wizard
  end

  def update
    case step
    when :basic_info
    when :details
      @tags = Tag.all
    when :publish
    end
    @course.update(course_params)
    render_wizard @course
  end

  def finish_wizard_path
    @course = Course.friendly.find params[:course_id]
    course_path(@course)
  end

  private
    def set_progress
      if wizard_steps.any? && wizard_steps.index(step).present?
        @progress = ((wizard_steps.index(step) + 1).to_d / wizard_steps.count.to_d) * 100
      else
        @progress = 0
      end
    end

    def set_course
      @course = Course.friendly.find params[:course_id]
    end

    def course_params
      params.require(:course).permit(:title, :description, :marketing_description, :price,
        :published, :language, :level, :avatar, tag_ids: [])
    end

    def authorize!
      authorize @course, :edit?
    end
end
