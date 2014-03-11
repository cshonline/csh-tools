require 'test_helper'

class StockMailerTest < ActionMailer::TestCase
  test "big_vol_mail" do
    mail = StockMailer.big_vol_mail
    assert_equal "Big vol mail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
