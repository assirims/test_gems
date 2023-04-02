class CoursesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ show ]
  before_action :set_course, only: %i[ show edit update destroy approve unapprove publish unpublish analytics ]

  # GET /courses
  def index
    @ransack_path = courses_path #set path for navbar search
    @ransack_courses = Course.published.approved.ransack(params[:courses_search], search_key: :courses_search) #navbar search
    @courses = @ransack_courses.result.includes(:user) #navbar search
    @pagy, @courses = pagy(@courses, items: 5) #gem pagy
  end

  def index_admin
    @ransack_path = courses_path #set path for navbar search
    @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search)
    @courses = @ransack_courses.result.includes(:user)
    @pagy, @courses = pagy(@courses, items: 5) #gem pagy
  end

  def analytics
    authorize @course, :owner?
  end

  def purchased
    @ransack_path = purchased_courses_path #navbar search
    @ransack_courses = Course.joins(:enrollments).where(enrollments: {user: current_user}).ransack(params[:courses_search], search_key: :courses_search) #sql query for purchased courses
    @pagy, @courses = pagy(@ransack_courses.result.includes(:user), items: 2) #gem pagy
    render :index
  end

  def pending_review
    @ransack_path = pending_review_courses_path #navbar search
    @ransack_courses = Course.joins(:enrollments).merge(Enrollment.pending_review.where(user: current_user)).ransack(params[:courses_search], search_key: :courses_search) #sql query for pending review courses
    @pagy, @courses = pagy(@ransack_courses.result.includes(:user), items: 2) #gem pagy
    render :index
  end

  def created
    @ransack_path = created_courses_path #navbar search
    @ransack_courses = Course.where(user: current_user).ransack(params[:courses_search], search_key: :courses_search) #sql query for created courses
    @pagy, @courses = pagy(@ransack_courses.result.includes(:user), items: 2) #gem pagy
    render :index
  end

  def unapproved
    @ransack_path = unapproved_courses_path
    @ransack_courses = Course.unapproved.ransack(params[:courses_search], search_key: :courses_search)
    @pagy, @courses = pagy(@ransack_courses.result.includes(:user))
    render :index_admin
  end

  def approve
    authorize @course, :approve?
    @course.update_attribute(:approved, true)
    # if action was index admin then redirect to index admin
    if request.referrer.include? "index_admin"
      redirect_to request.referer, notice: "Course approved and visible!"
    else
      redirect_to @course, notice: "Course approved and visible!"
    end
  end

  def unapprove
    authorize @course, :approve?
    @course.update_attribute(:approved, false)
    if request.referrer.include? "index_admin"
      redirect_to request.referer, notice: "Course upapproved and hidden!"
    else
      redirect_to @course, notice: "Course upapproved and hidden!"
    end
  end

  def unpublished #homepage link to unpublished courses
    @ransack_path = unpublished_courses_path
    @ransack_courses = Course.unpublished.ransack(params[:courses_search], search_key: :courses_search)
    @pagy, @courses = pagy(@ransack_courses.result.includes(:user))
    render :index_admin
  end

  def publish #the action used with buttons to publish a course
    authorize @course, :publish?
    @course.update_attribute(:published, true)
    if request.referrer.include? "index_admin"
      redirect_to request.referer, notice: "Course published!"
    else
      redirect_to unpublished_courses_path, notice: "Course published!"
    end
  end

  def unpublish #the action used with buttons to unpublish a course
    authorize @course, :publish?
    @course.update_attribute(:published, false)
    if request.referrer.include? "index_admin"
      redirect_to request.referer, notice: "Course unpublished!"
    else
      redirect_to unpublished_courses_path, notice: "Course unpublished!"
    end
  end

  # GET /courses/1
  def show
    authorize @course #gem pundit
    @lessons = @course.lessons.rank(:row_order) #gem ranked-model
    @pagy, @lessons = pagy(@lessons, items: 5) #gem pagy
    @enrollments_with_review = @course.enrollments.reviewed
  end

  # GET /courses/new
  def new
    @course = Course.new
    authorize @course #gem pundit it must be after @course = Course.new
  end

  # GET /courses/1/edit
  def edit
    authorize @course #gem pundit
  end

  # POST /courses
  def create
    @course = Course.new(course_params)
    authorize @course #gem pundit it must be after @course = Course.new
    @course.user = current_user
    if @course.save
      redirect_to @course, notice: "Course was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/1
  def update
    authorize @course #gem pundit
    if @course.update(course_params)
      redirect_to @course, notice: "Course was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /courses/1
  def destroy
    authorize @course #gem pundit
    if @course.destroy
      redirect_to courses_url, notice: "Course was successfully destroyed."
    else
      redirect_to @course, alert: "Course can't be destroyed because it has enrollments"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:title, :description, :short_description, :language, :level, :price, :published)
    end
end
