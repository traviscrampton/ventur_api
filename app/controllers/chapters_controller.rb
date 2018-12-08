class ChaptersController < ApplicationController

  def create
    journal = Journal.find(params[:journalId])
    @chapter = journal.chapters.new(non_image_chapter_params)
    if @chapter.save
      @chapter.create_distance(amount: 0) 
      handle_image_upload
      render json: chapter_json
    else
      render json: { errors: @chapter.errors.full_messages }, status: 422
    end
  end

  def upload_offline_chapter
    journal = Journal.find(params[:journalId])
    @chapter = journal.chapters.new(non_image_chapter_params)
    if @chapter.save
      @chapter.create_distance(amount: params[:distance])
      handle_image_upload
      BlogImageCurator.new(@chapter, params[:files]).call
      render json: chapter_json
    else
      render json: { errors: @chapter.errors.full_messages }, status: 422
    end
  end

  def update
    @chapter = Chapter.find(params[:id])
    if @chapter.update(non_image_chapter_params)
      handle_distance_update
      handle_image_upload
      render json: chapter_json
    else
      render json: { errors: @chapter.errors.full_messages }, status: 422
    end
  end

  def update_blog_content
    @chapter = Chapter.find(params[:id])
    if @chapter.update(content: params[:content])
      BlogImageCurator.new(@chapter, params[:files]).call
      render json: chapter_json
    else
      render json: { errors: @chapter.errors.full_messages }, status: 422
    end
  end

  def destroy
    @chapter = Chapter.find(params[:id])
    if current_user.id == @chapter.journal.user_id
      @chapter.delete
      render json: @chapter
    else
      render json: { error: "you cannot delete this chapter" }
    end
  end

  private 

  def non_image_chapter_params
    params.permit(:title, :description, :published, :offline, :date, :content)
  end

  def handle_distance_update
    return if !params[:distance]

    @chapter.distance.update(amount: params[:distance])
    @chapter.journal.distance.update(amount: @chapter.journal.calculate_total_distance)
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
      content: @chapter.content,
      dateCreated: @chapter.readable_date,
      bannerImageUrl: @chapter.banner_image_url,
      offline: @chapter.offline,
      distance: @chapter.distance.amount,
      published: @chapter.published,
      blogImageCount: @chapter.blog_image_count,
      date: @chapter.numbered_date,
      readableDate: @chapter.readable_date,
      slug: @chapter.slug,
      journal: {
        id: @chapter.journal.id,
        title: @chapter.journal.title,
        miniBannerImageUrl: @chapter.journal.mini_banner_image_url,
        distance: @chapter.journal.distance.amount
      }, 
      user: {
        id: @chapter.journal.user.id,
        fullName: @chapter.user.full_name
      }
    }
  end
end