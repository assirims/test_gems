class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]

  # GET /courses
  def index
    # @courses = Course.all
    # if params[:title]
    #   @courses = Course.where("title LIKE ?", "%#{params[:title]}%") #case-insensitive
    # else
      # @courses = Course.all
      # @q = Course.ransack(params[:q])
      # @courses = @q.result(distinct: true)
    # end
    # if current_user.has_role? :admin
      @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search)
      @courses = @ransack_courses.result.includes(:user)
    # else
    #   redirect_to root_path, alert: "You are not authorized to access this page."
    # end
  end

  # GET /courses/1
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  def create
    @course = Course.new(course_params)
    @course.user = current_user
    if @course.save
      redirect_to @course, notice: "Course was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      redirect_to @course, notice: "Course was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /courses/1
  def destroy
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
