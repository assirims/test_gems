class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :privacy_policy]

  def index
    @latest_good_reviews = Enrollment.reviewed.latest_good_reviews
    @latest = Course.latest.published.approved
    @top_rated = Course.top_rated.published.approved
    @popular = Course.popular.published.approved

    @purchased_courses = Course.joins(:enrollments).where(enrollments: {user: current_user}).order(created_at: :desc).limit(3)
  end

  def activity
    if current_user.has_role?(:admin)
      @pagy, @activities = pagy(PublicActivity::Activity.all.order(created_at: :desc), items: 10)
    else
      redirect_to root_path, alert: "You are not authorized to view this page."
    end
  end

  def analytics
    if current_user.has_role?(:admin)
    else
      redirect_to root_path, alert: "You are not authorized to view this page."
    end
  end

  def privacy_policy; end
end

# https://stackoverflow.com/a/45430044
# gem install rails_refactor
# rails_refactor rename StaticPagesController HomeController
# rails_refactor rename HomeController.landing_page index
