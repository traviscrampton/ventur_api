class JournalsController < ApplicationController
  before_action :check_current_user

  def create
    @journal = current_user.journals.new(non_image_params)

    if @journal.save
      @journal.create_distance(amount: 0) 
      @journal.banner_image.attach(params[:banner_image]) if params[:banner_image]
      render json: journal_json
    else
      render json: @journal.errors
    end
  end

  def update
    @journal = Journal.find(params[:id])
    check_journal_user
    if @journal.update(non_image_params)
      handle_image_upload
      render json: journal_json
    else
      render json: @journal.errors
    end
  end

  private 

  def non_image_params
   params.permit(:title, :description, :stage, :status)
  end

  def check_journal_user
    return if current_user.id == @journal.user_id

    return_unauthorized_error
  end

  def handle_image_upload
    return if !params[:banner_image] 
    
    @journal.banner_image.purge if @journal.banner_image.attached?
    @journal.banner_image.attach(params[:banner_image]) 
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