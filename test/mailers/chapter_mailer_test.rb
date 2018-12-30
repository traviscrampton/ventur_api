require 'test_helper'

class ChapterMailerTest < ActionMailer::TestCase
  test "new_chapter" do
    mail = ChapterMailer.new_chapter
    assert_equal "New chapter", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
