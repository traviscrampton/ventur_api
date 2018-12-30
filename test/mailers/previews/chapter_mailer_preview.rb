# Preview all emails at http://localhost:3000/rails/mailers/chapter_mailer
class ChapterMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/chapter_mailer/new_chapter
  def new_chapter
    ChapterMailer.new_chapter
  end

end
