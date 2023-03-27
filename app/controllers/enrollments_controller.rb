class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: %i[ show edit update destroy ]
  before_action :set_course, only: %i[ new create ]
  before_action :authorize_enrollment, only: %i[ update edit destroy ]

  # GET /enrollments
  def index
    @enrollments = Enrollment.all
    authorize_enrollment
  end

  # GET /enrollments/1
  def show
  end

  # GET /enrollments/new
  def new
    @enrollment = Enrollment.new
  end

  # GET /enrollments/1/edit
  def edit
  end

  # POST /enrollments
  def create
    if @course.price > 0
      flash[:alert] = "You can't enroll in a paid course"
      redirect_to new_course_enrollment_path(@course)
    else
      @enrollment = current_user.buy_course(@course)
      redirect_to course_path(@course), notice: "You have successfully enrolled in the course"
      # @enrollment.price = @enrollment.course.price unless @enrollment.course_id.nil?
    end
  end

  # PATCH/PUT /enrollments/1
  def update
    if @enrollment.update(enrollment_params)
      redirect_to @enrollment, notice: "Enrollment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /enrollments/1
  def destroy
    @enrollment.destroy
    redirect_to enrollments_url, notice: "Enrollment was successfully destroyed."
  end

  private
    def set_course
      @course = Course.friendly.find(params[:course_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def enrollment_params
      params.require(:enrollment).permit(:rating, :review)
    end

    def authorize_enrollment
      authorize(@enrollments || @enrollment)
    end
end
