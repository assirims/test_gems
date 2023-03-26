class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]

  # GET /courses
  def index
    @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search) #navbar search
    @courses = @ransack_courses.result.includes(:user) #navbar search
    @pagy, @courses = pagy(@courses, items: 5) #gem pagy
  end

  # GET /courses/1
  def show
    @lessons = @course.lessons
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
    @course.destroy
    redirect_to courses_url, notice: "Course was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:title, :description, :short_description, :language, :level, :price)
    end
end
