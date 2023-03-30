class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :privacy_policy]

  def index
    @courses = Course.all.limit(3)
    @latest_couses = Course.all.limit(3).order(created_at: :desc)

    @latest_good_reviews = Enrollment.reviewed.order(rating: :desc, created_at: :desc).limit(3)
    @top_rated_courses = Course.order(average_rating: :desc, created_at: :desc).limit(3)
    @popular_courses = Course.order(enrollments_count: :desc, created_at: :desc).limit(3)
    @purchased_courses = Course.joins(:enrollments).where(enrollments: {user: current_user}).order(created_at: :desc).limit(3)
  end

  def activity
    @activities = PublicActivity::Activity.all.order(created_at: :desc)
  end

  def privacy_policy
  end
end

# https://stackoverflow.com/a/45430044
# gem install rails_refactor
# rails_refactor rename StaticPagesController HomeController
# rails_refactor rename HomeController.landing_page index
