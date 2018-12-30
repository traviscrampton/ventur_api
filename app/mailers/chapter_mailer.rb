class ChapterMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.chapter_mailer.new_chapter.subject
  #

  def new_chapter(chapter, email)
    @chapter = chapter

    mail to: email, subject: "New Post!"
  end
end
