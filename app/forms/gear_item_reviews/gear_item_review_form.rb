class GearItemReviewForm
  include ProsConsManager

  attr_accessor( 
    :params,
    :gear_item,
    :gear_item_id,
    :gear_item_review,
    :rating,
    :current_user,
    :pros,
    :cons,
    :journal_ids,
    :gear_item_review_id,
    :name,
    :images,
    :review
  )

  def initialize(params, current_user)
    @params = params
    @gear_item_review ||= GearItemReview.find_by_id(gear_item_review_id)
    set_up_params
    @gear_item = GearItem.find_by_id(gear_item_id)
    @current_user = current_user
  end

  def create
    create_gear_item
    create_gear_item_review
    @gear_item_review
  end

  def update
    update_gear_item_review
  end

  private

  def create_gear_item
    return if @gear_item

    @gear_item = GearItem.new(name: name, image_url: take_first_image)
    if @gear_item.save
      # do something to make sure we know that this is infact happening
    else
      # raise hell
    end
  end

  def create_gear_item_review
    @gear_item_review = @gear_item.gear_item_reviews
                                .new(
                                      images: images,
                                      rating: rating,
                                      review: review,
                                      user_id: current_user.id
                                     )

    if @gear_item_review.save
      create_pros_cons(gear_item_review, pros, cons)
      create_journal_associations
    else
      binding.pry
    end
  end

  def create_journal_associations
    # its assumed that the user check has happened already

    journal_ids.each do |journal_id|
      @gear_item_review.gear_item_reviews_journals.create(journal_id: journal_id)
    end
  end

  def take_first_image
    return "" if !images

    parsed_images = JSON.parse(images)
    return "" if images.empty?

    
    return parsed_images[0]["originalUri"]
  end

  def update_gear_item_review
    #  updategear item review
  end


  def set_up_params
    @name = params[:name]
    @gear_item_id = params[:gearItemId]
    @pros = JSON.try(:parse, params[:pros]) || []
    @cons = JSON.try(:parse, params[:cons]) || []
    @images = params[:images]
    @review = params[:review]
    @rating = params[:rating]
    @gear_item_review_id = params[:gear_item_review_id]
    @journal_ids = JSON.try(:parse, params[:journalIds]) || []
  end
end
