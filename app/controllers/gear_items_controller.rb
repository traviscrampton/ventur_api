class GearItemsController < ApplicationController

	def create
    @journal = Journal.find(params[:journalId])
    @gear_item = @journal.gear_items.new(non_image_gear_item_params)
		validate_journal_user

    if @gear_item.save
      handle_image_upload
      render json: gear_item_json
    else
      render json: { errors: @gear_item.errors.full_messages }, status: 422
    end
  end

  def upload_offline_gear_item
    journal = Journal.find(params[:journalId])
    @gear_item = journal.gear_items.new(non_image_gear_item_params)
    validate_journal_user
    if @gear_item.save      
      handle_image_upload
      GearItemCurator.new(@gear_item, params[:files]).call
      GC.start if Rails.env.production?
      render json: gear_item_json
    else
      render json: { errors: @gear_item.errors.full_messages }, status: 422
    end
  end

	def update
    @gear_item = gear_item.find(params[:id])
    validate_journal_user
    if @gear_item.update(non_image_gear_item_params)
      handle_image_upload
      render json: gear_item_json
    else
      render json: { errors: @gear_item.errors.full_messages }, status: 422
    end
  end

  def update_blog_content
    @gear_item = GearItem.find(params[:id])
    validate_journal_user
    if @gear_item.update(content: params[:content])
      GearItemCurator.new(@gear_item, params[:files]).call
      render json: gear_item_json
    else
      render json: { errors: @gear_item.errors.full_messages }, status: 422
    end
  end

  def destroy
    @gear_item = GearItem.find(params[:id])
    validate_journal_user
    if current_user.id == @gear_item.journal.user_id
      @gear_item.delete
      render json: @gear_item
    else
      render json: { error: "you cannot delete this gear_item" }
    end
  end

	def show
    @gear_item = GearItem.find(params[:id])
    render json: @gear_item
  end

  private 

  def validate_journal_user
    return if current_user.id == @journal.user_id

    return_unauthorized_error
  end

  def non_image_gear_item_params
    params.permit(:title, :published, :content, :price)
  end

  def handle_image_upload
    return if !params[:product_image] 

    @gear_item.product_image.purge if @gear_item.product_image.attached?
    @gear_item.product_image.attach(params[:product_image]) 
  end

  def gear_item_json 
    {
      id: @gear_item.id,
      title: @gear_item.title,
      productImageUrl: @gear_item.product_image_url,
      published: @gear_item.published,
      journal: {
        id: @journal.id,
        title: @journal.title,
        distance: @journal.distance.amount.to_i
      }
    }
  end
end