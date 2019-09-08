class GearItemReviewsController < ApplicationController
  before_action :gear_item_review, only: [:show]

  def index
    @gear_item_reviews = Journal.includes(gear_item_reviews: [:gear_item, :pros_cons])
                                .find(params[:journal_id])
                                .gear_item_reviews

    render 'gear_item_reviews/index.json'                               
  end

  def create
    @gear_item_review = GearItemReviewForm.new(gear_review_params, current_user).create

    
  end

  def update
    @gear_item_review = GearItemReviewForm.new(params).update

    # render something
  end

  def show
    # i'd like to find a better way of doing this but
    # using .select will take an extra query
    pros, cons = gear_item_review.pros_cons
                                 .map { |pc| { id: pc.id, text: pc.text, isPro: pc.is_pro }}
                                 .partition { |pc| pc[:isPro] }

    render 'gear_item_reviews/show.json', { locals: { pros: pros, cons: cons}}
  end

  private

  def gear_item_review
    @gear_item_review ||= GearItemReview.includes(:gear_item, :pros_cons)
                                        .find(params[:id])
  end

  def gear_review_params
    params.permit(:gearItemId, :name, :images, :cons, :pros, :journalIds, :rating, :review)
  end
end