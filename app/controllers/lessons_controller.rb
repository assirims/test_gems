class LessonsController < ApplicationController
  before_action :set_lesson, only: %i[ show edit update destroy ]
  before_action :authorize_valuations, except: %i[ index new create]

  # GET /lessons
  def index
    @ransack_lessons = Lesson.ransack(params[:lessons_search], search_key: :lessons_search)
    # @ransack_lessons.sorts = ['id desc'] if @ransack_lessons.sorts.empty?
    @lessons = @ransack_lessons.result(distinct: true)
  end

  # GET /lessons/1
  def show
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
    @course = Course.friendly.find(params[:course_id])
    authorize_valuations
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  def create
    @lesson = Lesson.new(lesson_params)
    @course = Course.friendly.find(params[:course_id])
    @lesson.course_id = @course.id
    authorize_valuations
    if @lesson.save
      redirect_to course_lesson_path(@course, @lesson), notice: "Lesson was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lessons/1
  def update
    if @lesson.update(lesson_params)
      redirect_to course_lesson_path(@course, @lesson), notice: "Lesson was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /lessons/1
  def destroy
    @lesson.destroy
    redirect_to course_lessons_url, notice: "Lesson was successfully destroyed."
  end

  private
  # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @course = Course.friendly.find(params[:course_id])
      @lesson = Lesson.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      params.require(:lesson).permit(:title, :content, :course_id)
    end

    def authorize_valuations
      # authorize @lesson # policy: test_gems/app/policies/lesson_policy.rb
      authorize(@lessons || @lesson)
    end

end
