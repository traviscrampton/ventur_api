class ChaptersController < ApplicationController

  def create
    journal = Journal.find(params[:journalId])
    @chapter = journal.chapters.new(non_image_chapter_params)
    if @chapter.save
      @chapter.create_distance(amount: params[:distance])
      handle_image_upload
      render json: @chapter
    else
      render json: @chapter.errors
    end
  end

  def update
    @chapter.find(params[:id])
    if @chapter.update(non_image_chapter_params)
      @chapter.distance.update(amount: params[:distance])
      handle_image_upload
      render json: @chapter
    else
      render json: @chapter.errors
    end
  end

  private 

   def non_image_chapter_params
     params.permit(:title, :description)
   end

  def handle_image_upload
    return if !params[:banner_image] 
    
    @chapter.banner_image.purge if @chapter.banner_image.attached?
    @chapter.banner_image.attach(params[:banner_image]) 
  end
end