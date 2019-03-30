class NewFollowerMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.chapter_mailer.new_chapter.subject
  #

  def new_follower(new_email, user_email, journal_title)
    @new_email = new_email
    @journal_title = journal_title

    mail to: user_email, subject: "New Journal Follow"
  end
end
