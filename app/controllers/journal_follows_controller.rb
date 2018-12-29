class JournalFollowsController < ApplicationController
  before_action :check_for_current_user, only: :destroy
  
  def create
    if current_user
      if check_for_email_follow_and_update
        render json: { followed: true }
      end

      journal_follow = JournalFollow.new(journal_id: params[:journalId], user_id: current_user.id, user_email: current_user.email)
    else
      journal_follow = JournalFollow.new(journal_id: params[:journalId], user_email: params[:userEmail])
    end

    if journal_follow.save
      render json: { followed: true }
    else
      render json: { errors: journal_follow.errors.full_messages }, status: 422
    end
  end

  def destroy
    @journal_follow = JournalFollow.find_by(journal_id: params[:journalId], user_email: current_user.email)

    if @journal_follow.delete
      render json: { followed: false }
    else
      render json: { errors: @journal_follow.errors.full_messages }, status: 422
    end
  end

  private

  def check_for_email_follow_and_update
    journal_follow = JournalFollow.find_by(email: current_user.email)
    if journal_follow.present? && journal_follow.user_id.nil?
      journal_follow.update(user_id: current_user.id)
      return true
    else
      return false
    end
  end

  def check_for_current_user
    return if current_user

    return_unauthorized_error
  end
end