class JournalsController < ApplicationController

  def create
    @journal = current_user.journals.new(non_image_params)

    if @journal.save
      @journal.banner_image.attach(params[:banner_image]) if params[:banner_image]
      render json: journal_json
    else
      render json: @journal.errors
    end
  end

  private 

   def non_image_params
     params.permit(:title, :description, :stage, :status)
   end

   def journal_json
    {
      id: @journal.id,
      title: @journal.title,
      description: @journal.description,
      cardBannerImageUrl: @journal.card_banner_image_url,
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