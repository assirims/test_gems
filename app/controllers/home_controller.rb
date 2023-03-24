class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :privacy_policy]

  def index
    @courses = Course.all.limit(3)
    @latest_couses = Course.all.limit(3).order(created_at: :desc)
  end

  def activity
    @activities = PublicActivity::Activity.all
  end

  def privacy_policy
  end
end

# https://stackoverflow.com/a/45430044
# gem install rails_refactor
# rails_refactor rename StaticPagesController HomeController
# rails_refactor rename HomeController.landing_page index
