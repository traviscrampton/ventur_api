class JournalFollowsController < ApplicationController
  before_action :check_for_current_user, only: :destroy
  
  def create
    if current_user
      if check_for_email_follow_and_update
        render json: { isFollowing: true }
      end

      journal_follow = JournalFollow.new(journal_id: params[:journalId], user_id: current_user.id, user_email: current_user.email)
    else
      journal_follow = JournalFollow.new(journal_id: params[:journalId], user_email: params[:userEmail])
    end

    if journal_follow.save
      render json: { isFollowing: true }
    else
      render json: { errors: journal_follow.errors.full_messages }, status: 422
    end
  end

  def destroy
    @journal_follow = JournalFollow.find_by(journal_id: params[:journalId], user_email: current_user.email)

    if @journal_follow.delete
      render json: { isFollowing: false }
    else
      render json: { errors: @journal_follow.errors.full_messages }, status: 422
    end
  end

  def send_chapter_emails
    @chapter = Chapter.find(params[:id])
    follower_emails = @chapter.journal.journal_follows.map(&:user_email)
    @chapter.update(email_sent: true)

    follower_emails.each do |email|
      ChapterMailer.new_chapter(@chapter, email).deliver_later
    end

    render json: chapter_json
  end

  private

    def chapter_json 
    {
      id: @chapter.id,
      title: @chapter.title,
      description: @chapter.description,
      content: @chapter.content,
      dateCreated: @chapter.readable_date,
      bannerImageUrl: @chapter.banner_image_url,
      offline: @chapter.offline,
      distance: @chapter.distance.amount.to_i,
      published: @chapter.published,
      blogImageCount: @chapter.blog_image_count,
      date: @chapter.numbered_date,
      readableDate: @chapter.readable_date,
      emailSent: @chapter.email_sent,
      slug: @chapter.slug,
      journal: {
        id: @chapter.journal.id,
        title: @chapter.journal.title,
        miniBannerImageUrl: @chapter.journal.mini_banner_image_url,
        distance: @chapter.journal.distance.amount.to_i
      }, 
      user: {
        id: @chapter.journal.user.id,
        fullName: @chapter.user.full_name
      }
    }
  end

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