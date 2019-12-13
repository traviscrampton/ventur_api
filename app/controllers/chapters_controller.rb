class ChaptersController < ApplicationController
  before_action :check_current_user, except: [:show, :index]
  before_action :validate_journal_user, except: [:show, :index]

  def show
    @chapter = Chapter.with_attached_banner_image
                      .includes(:distance, :cycle_route,
                                :editor_blob, journal: [:chapters, :user])
                      .find(params[:id])
    render 'chapters/show.json', locals: { current_user: current_user }
  end

  def index
    @journal = Journal.includes(chapters: :distance,
                                banner_image_attachment: :blob)
                      .find(params[:journal_id])

    @chapters = @journal.send(chapters_based_on_user)



    render "chapters/index.json"                   
  end

  def create
    @chapter = CreateChapter.new(params).call

    render_chapter
  end

  def upload_offline_chapter # TODO: Port over to EditorBlob
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
    @chapter = UpdateChapter.new(params).call

    render_chapter
  end

  def update_blog_content # port over to EditorBlob
    @chapter = Chapter.find(params[:id])
    if @chapter.update(content: params[:content])
      BlogImageCurator.new(@chapter, params[:files]).call
      GC.start if Rails.env.production?
      render json: chapter_json
    else
      GC.start if Rails.env.production? 
      render json: { errors: @chapter.errors.full_messages }, status: 422
    end
  end

  def destroy
    @chapter = Chapter.find(params[:id])
    if @chapter.delete
      @chapter.journal.update_total_distance
      render json: @chapter
    else
      render json: { error: "you cannot delete this chapter" }
    end
  end

  private 

  def render_chapter
    if @chapter.valid?
      render 'chapters/_chapter.json'
    else
      render json: { errors: @chapter.errors.full_messages }, status: 422
    end
  end

  def chapters_based_on_user
    if current_user && current_user.id == @journal.user_id
      :all_chapters
    else
      :published_chapters
    end
  end

  def validate_journal_user
    chapter_user_id = if params[:journalId]
                        Journal.find(params[:journalId]).user.id
                      elsif params[:id]
                        Chapter.find(params[:id]).user.id
                      end

    return if chapter_user_id == current_user.id

    return_unauthorized_error
  end


  def non_image_chapter_params # TODO: remove
    params.permit(:title, :description, :published, :offline, :date, :content)
  end

  def handle_distance_update # TODO: remove
    return if !params[:distance]

    @chapter.distance.update(amount: params[:distance])
    @chapter.journal.distance.update(amount: @chapter.journal.calculate_total_distance)
  end

  def handle_image_upload # TODO: remove
    return if !params[:banner_image] 

    @chapter.banner_image.purge if @chapter.banner_image.attached?
    @chapter.banner_image.attach(params[:banner_image]) 
  end

  def chapter_json # TODO: remove
    {
      id: @chapter.id,
      title: @chapter.title,
      description: @chapter.description,
      content: @chapter.content,
      dateCreated: @chapter.readable_date,
      bannerImageUrl: @chapter.banner_image_url,
      offline: @chapter.offline,
      distance: @chapter.distance.amount.to_i,
      published: @chapter.published,
      blogImageCount: @chapter.blog_image_count,
      date: @chapter.numbered_date,
      readableDate: @chapter.readable_date,
      slug: @chapter.slug,
      journal: {
        id: @chapter.journal.id,
        title: @chapter.journal.title,
        miniBannerImageUrl: @chapter.journal.mini_banner_image_url,
        distance: @chapter.journal.distance.amount.to_i
      }, 
      user: {
        id: @chapter.journal.user.id,
        fullName: @chapter.user.full_name
      }
    }
  end
end