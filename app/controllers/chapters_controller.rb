class ChaptersController < ApplicationController

  def create
    journal = Journal.find(params[:journalId])
    @chapter = journal.chapters.new(non_image_chapter_params)
    if @chapter.save
      @chapter.create_distance(amount: params[:distance])
      handle_image_upload
      render json: chapter_json
    else
      render json: @chapter.errors
    end
  end

  def update
    @chapter = Chapter.find(params[:id])
    if @chapter.update(non_image_chapter_params)
      @chapter.distance.update(amount: params[:distance])
      handle_image_upload
      render json: @chapter
    else
      render json: @chapter.errors
    end
  end

  def update_blog_content
    @chapter = Chapter.find(params[:id])
    if @chapter.update(content: params[:content])
      BlogImageCurator.new(@chapter, params[:files]).call
      render json: @chapter.content
    else
      render json: @chapter.errors
    end
  end

  private 

   def non_image_chapter_params
     params.permit(:title, :description, :stage)
   end

  def handle_image_upload
    return if !params[:banner_image] 
    
    @chapter.banner_image.purge if @chapter.banner_image.attached?
    @chapter.banner_image.attach(params[:banner_image]) 
  end

  def chapter_json 
    {
      id: @chapter.id,
      title: @chapter.title,
      description: @chapter.description,
      distance: @chapter.distance.amount,
      journalId: @chapter.journal.id,
      user: {
        id: @chapter.journal.user.id
      }
    }
  end
end