class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: %i[ show edit update destroy certificate ]
  before_action :set_course, only: %i[ new create ]
  before_action :authorize_enrollment, only: %i[ update edit destroy ]

  # GET /enrollments
  def index
    @ransack_path = enrollments_path #set path

    @ranked_enrollments = Enrollment.ransack(params[:q])
    @enrollments = @ranked_enrollments.result.includes(:user, :course)
    @pagy, @enrollments = pagy(@enrollments, items: 5)
    authorize_enrollment
  end

  def my_students
    @ransack_path = my_students_enrollments_path #set path
    @ranked_enrollments = Enrollment.joins(:course).where(courses: {user: current_user}).ransack(params[:q])
    @pagy, @enrollments = pagy(@ranked_enrollments.result.includes(:user), items: 1)
    render :index
  end

  # GET /enrollments/1
  def show
  end

  def certificate
    authorize @enrollment, :certificate?
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@enrollment.course.title}, #{@enrollment.user.email}",
        template: "enrollments/certificate"
      end
    end
  end

  # GET /enrollments/new
  def new
    @enrollment = Enrollment.new
  end

  # GET /enrollments/1/edit
  def edit; end

  # POST /enrollments
  def create
    if @course.price > 0
      @amount = (@course.price * 100).to_i
      # gem 'stripe' to use Stripe API
      # customer = Stripe::Customer.create(
      #   email: params[:stripeEmail],
      #   source: params[:stripeToken]
      # )
      # charge = Stripe::Charge.create(
      #   customer:    customer.id,
      #   amount:      (@course.price * 100).to_i,
      #   description: @course.title,
      #   currency:    'usd'
      # )
      @enrollment = current_user.buy_course(@course)
      redirect_to course_path(@course), notice: "You are enrolled!"
    else
      @enrollment = current_user.buy_course(@course)
      redirect_to course_path(@course), notice: "You are enrolled!"
    end
    # EnrollmentMailer.student_enrollment(@enrollment).deliver_later
    # EnrollmentMailer.teacher_enrollment(@enrollment).deliver_later
    # rescue Stripe::CardError => e {
      # flash[:error] = e.message
      # redirect_to new_course_enrollment_path(@course)
    # }
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
    if @enrollment.destroy
      # redirect_to course_path(@course), notice: "You are enrolled!"
      redirect_to request.referer, notice: "Enrollment was successfully destroyed."
    else
      redirect_to @enrollment, alert: "Enrollment can't be destroyed because it has enrollments"
    end
  end

  private
    def set_course
      @course = Course.friendly.find(params[:course_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      # Enrollment.find_each(&:save) >> rails c
      @enrollment = Enrollment.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def enrollment_params
      params.require(:enrollment).permit(:rating, :review)
    end

    def authorize_enrollment
      authorize(@enrollments || @enrollment)
    end
end
