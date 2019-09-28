class GearItemReviewsController < ApplicationController
  before_action :gear_item_review, only: [:show, :destroy]
  before_action :parent_klass

  def index
    @gear_item_reviews = @parent.gear_item_reviews

    render 'gear_item_reviews/index.json'                               
  end

  def create
    @gear_item_review = GearItemReviewForm.new(gear_review_params, current_user).create

    if @gear_item_review.errors.any?
      render json: { errors: @gear_item_review.errors.full_messages }, status: 422
    else
      partition_and_render
    end
  end

  def update
    @gear_item_review = GearItemReviewForm.new(gear_review_params, current_user).update

    partition_and_render
  end

  def show
    partition_and_render
  end

  def destroy
    @gear_item_review.destroy

    render json: @gear_item_review
  end

  private

  def parent_klass
    parent_klasses = %w[user journal]

    if klass = parent_klasses.detect { |pk| params[:"#{pk}_id"].present? }
      @parent = klass.camelize.constantize
                     .includes(gear_item_reviews: [:gear_item, :pros_cons])
                     .find(params[:"#{klass}_id"])
    end
  end

  def gear_item_review
    @gear_item_review ||= GearItemReview.includes(:gear_item, :pros_cons)
                                        .find(params[:id])
  end

  def partition_and_render
    pros, cons = partition_pros_cons

    render 'gear_item_reviews/show.json', { locals: { pros: pros, cons: cons}}
  end

  def partition_pros_cons
    gear_item_review.pros_cons
                    .map { |pc| { id: pc.id, text: pc.text, isPro: pc.is_pro }}
                    .partition { |pc| pc[:isPro] }
  end

  def gear_review_params
    params.permit(:gearItemId, :id, :name, :images, :cons, :pros, :journalIds, :rating, :review)
  end
end