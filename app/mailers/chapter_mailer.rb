class ChapterMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.chapter_mailer.new_chapter.subject
  #

  def new_chapter(chapter, full_name, email)
    @chapter = chapter
    @full_name = full_name

    mail to: email, subject: "New Post from #{@full_name}"
  end
end
