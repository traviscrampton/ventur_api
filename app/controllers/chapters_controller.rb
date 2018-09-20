class ChaptersController < ApplicationController

  def create
    journal = Journal.find(params[:journalId])
    chapter = journal.chapters.new(params[:title])
    if chapter.save
      render json: chapter
    else
      render json: chapter.errors
    end
  end

  def update
    @journal = Journal.find(params[:id])
    if @journal.update(non_image_params)
      handle_image_upload
      render json: journal_json
    else
      render json: @journal.errors
    end
  end

  private 

  def handle_image_upload
  end
  
  private 

   def journal_json
    {
      id: @journal.id,
      title: @journal.title,
      description: @journal.description,
      cardBannerImageUrl: @journal.banner_image.attached? ? @journal.card_banner_image_url : "",
      status: @journal.status,
      distance: 0,
      user: {
        id: @journal.user.id,
        fullName: @journal.user.full_name,
        avatarImageUrl: @journal.user.avatar_image_url
      },
      chapters: []
    }
   end
end