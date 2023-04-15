class TagsController < ApplicationController
  def index
    @tags = Tag.all.order(course_tags_count: :desc)
    authorize @tags
  end

  def new
    @tag = Tag.new
    # authorize @tag
  end

  def edit
    @tag = Tag.find(params[:id])
    # authorize @tag
  end

  def update
    @tag = Tag.find(params[:id])
    # authorize @tag
    if @tag.update(tag_params)
      redirect_to tags_path, notice: "Tag was successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_path, notice: "Tag was successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    authorize @tag
    @tag.destroy
    redirect_to tags_path, notice: "Tag was successfully destroyed"
  end

  private

    def tag_params
      params.require(:tag).permit(:name)
    end
end
