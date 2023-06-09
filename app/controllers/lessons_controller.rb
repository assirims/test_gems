class LessonsController < ApplicationController
  before_action :set_lesson, only: %i[ show edit update destroy delete_video ]
  before_action :authorize_valuations, except: %i[ index new create delete_video ]

  # GET /lessons
  def index; end

  def delete_video
    authorize @lesson, :edit?
    @lesson.video.purge if @lesson.video.attached?
    @lesson.video_thumbnail.purge if @lesson.video_thumbnail.attached?
    redirect_to edit_course_lesson_path(@course, @lesson), alert: "Video was successfully deleted."
  end

  # GET /lessons/1
  def show
    current_user.view_lesson(@lesson)
    @lessons = @course.lessons.rank(:position)
    @comment = Comment.new
    @comments = @lesson.comments.order(created_at: :desc)
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
    @course = Course.friendly.find(params[:course_id])
    authorize @lesson
  end

  # GET /lessons/1/edit
  def edit; end

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
    redirect_to course_path(@course), notice: "Lesson was successfully destroyed."
  end

  private
  # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @course = Course.friendly.find(params[:course_id])
      @lesson = Lesson.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      params.require(:lesson).permit(:title, :content, :video, :video_thumbnail)
    end

    def authorize_valuations
      # authorize @lesson # policy: test_gems/app/policies/lesson_policy.rb
      authorize(@lessons || @lesson)
    end

end
