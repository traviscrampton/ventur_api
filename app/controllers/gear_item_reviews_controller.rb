class GearItemReviewsController < ApplicationController
  skip_before_action :authenticate_token
  before_action :gear_item_review, only: [:show, :update]

  def index
    @gear_item_reviews = Journal.includes(gear_item_reviews: [:gear_item, :pros_cons])
                                .find(params[:journal_id])
                                .gear_item_reviews

    render 'gear_item_reviews/index.json'                               
  end

  def show
    # i'd like to find a better way of doing this but
    # using .select will take an extra query
    pros, cons = gear_item_review.pros_cons
                                 .map { |pc| { id: pc.id, text: pc.text, is_pro: pc.is_pro }}
                                 .partition { |pc| pc[:is_pro] }

    render 'gear_item_reviews/show.json', { locals: { pros: pros, cons: cons}}
  end

  private

  def gear_item_review
    @gear_item_review ||= GearItemReview.includes(:gear_item, :pros_cons)
                                        .find(params[:id])
  end
end