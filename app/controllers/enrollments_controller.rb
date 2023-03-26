class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: %i[ show edit update destroy ]

  # GET /enrollments
  def index
    @enrollments = Enrollment.all
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
    @enrollment = Enrollment.new(enrollment_params)
    # if @enrollment.course_id.nil?
      # @enrollment.price = 0
    # else
    @enrollment.price = @enrollment.course.price unless @enrollment.course_id.nil?
    # end

    if @enrollment.save
      redirect_to @enrollment, notice: "Enrollment was successfully created."
    else
      render :new, status: :unprocessable_entity
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
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def enrollment_params
      params.require(:enrollment).permit(:course_id, :user_id, :rating, :review)
    end
end
