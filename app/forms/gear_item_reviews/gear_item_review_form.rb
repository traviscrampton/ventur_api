class GearItemReviewForm

  attr_accessor :params, :gear_item, :gear_item_review

  def initialize(params)
    @params = params
    @gear_item = GearItem.find(params[:gearItemId])
    @gear_item_review ||= gear_item_review
    pros_cons = []
  end

  def create
    create_gear_item
    create_gear_item_review
  end

  def update
    update_gear_item_review
  end

  private

  def create_gear_item
    return if gear_item

    gear_item = GearItem.new(name: params[:name], image_url: take_first_image)
    if gear_item.save #make sure that this validation is giving back some sass
      # send an email notifiying admin that something is going down 
    end
  end

  def create_gear_item_review
    gear_item_review = gear_item.gear_item_reviews
                                .new(journal_id: params[:journal_id], images: params[:images], rating: params[:ratings])

    if gear_item_review.save
      create_pros_cons
    end                              
  end

  def create_pros_cons
    pros_cons = JSON.parse(params[:prosCons])
    return if pros_cons.length == 0

    pros_cons.each do |pro_con|
      next if pro_con[:id]

      gear_item_review.pros_cons.create(pro_con)
    end
  end

  def take_first_image
    return "" if !params[:images] 
    
    JSON.parse(params[:images])[:urls][:large]
  end

  def update_gear_item_review
    # update gear item review
  end
end
