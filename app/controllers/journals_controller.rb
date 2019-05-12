class JournalsController < ApplicationController
  before_action :check_current_user, except: [:index, :show]
  
  def index
    @journals = Journal.with_attached_banner_image
                       .includes(:distance, :countries,
                                 user: [avatar_attachment: :blob])
                       .where.not(status: 0)
                       .limit(10)
                       .order('created_at DESC')
    render 'journals/index.json'
  end

  def show
    @journal = Journal.with_attached_banner_image
                      .includes(:distance, :journal_follows,
                                :countries,
                                user: [avatar_attachment: :blob],
                                chapters: [:distance, banner_image_attachment: :blob],
                                gear_items: [product_image_attachment: :blob])
                      .find(params[:id])
    render 'journals/show.json', locals: { current_user: current_user }
  end

  def create
    @journal = CreateJournal.new(params, current_user).call

    if @journal.valid?
      render json: journal_json
    else
      render json: @journal.errors
    end
  end

  def update
    check_journal_user
    @journal = UpdateJournal.new(params).call

    if @journal.valid?
      render json: journal_json
    else
      render json: @journal.errors
    end
  end

  def destroy
    @journal = Journal.find(params[:id])
    check_journal_user
    @journal.delete
    render json: @journal
  end

  private 

  def non_image_params
   params.permit(:title, :description, :stage, :status, :distanceType)
  end

  def check_journal_user
    journal = Journal.find(params[:id])
    return if current_user.id == journal.user_id

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
      webBannerImageUrl: @journal.banner_image.attached? ? @journal.web_banner_image_url : "",
      status: @journal.status,
      countries: @journal.countries.map(&:name),
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