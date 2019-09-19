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
    set_up_params
    @gear_item_review ||= GearItemReview.find_by_id(gear_item_review_id)
    @gear_item = GearItem.find_by_id(gear_item_id)
    @current_user = current_user
  end

  def create
    create_gear_item
    return @gear_item if @gear_item.errors

    create_gear_item_review
    @gear_item_review
  end

  def update
    create_gear_item
    return @gear_item if @gear_item.errors
    
    update_gear_item_review
    @gear_item_review
  end

  private

  def create_gear_item
    return if @gear_item

    @gear_item = GearItem.new(name: name, image_url: take_first_image)
    @gear_item.save
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
      @gear_item_review
    end
  end

  def create_journal_associations
    journal_ids.each do |journal_id|
      @gear_item_review.gear_item_reviews_journals.create(journal_id: journal_id)
    end
  end

  def take_first_image
    return "" if !images

    parsed_images = JSON.parse(images)
    return "" if parsed_images.empty?

    
    return parsed_images[0]["originalUri"]
  end

  def update_gear_item_review
    if @gear_item_review.update(images: images, rating: rating, review: review, gear_item_id: @gear_item.id)
      update_all_pros_cons
      update_journal_ids
    else
    end
  end

  def update_all_pros_cons
    remove_pros_cons(@gear_item_review, pros, cons)
    update_pros_cons(@gear_item_review, pros, cons)
    create_pros_cons(@gear_item_review, pros, cons)
  end

  def update_journal_ids
    persisted_journal_ids = @gear_item_review.journals.map(&:id)
    
    journal_ids.each do |journal_id|
      next if persisted_journal_ids.include?(journal_id)
      @gear_item_review.gear_item_reviews_journals.create(journal_id: journal_id)
    end
  end

  def set_up_params
    @name = params[:name] || ""
    @gear_item_id = params[:gearItemId]
    @pros = JSON.try(:parse, params[:pros]) || []
    @cons = JSON.try(:parse, params[:cons]) || []
    @images = params[:images]
    @review = params[:review] || ""
    @rating = params[:rating] || 1
    @gear_item_review_id = params[:id]
    @journal_ids = JSON.try(:parse, params[:journalIds]) || []
  end
end
