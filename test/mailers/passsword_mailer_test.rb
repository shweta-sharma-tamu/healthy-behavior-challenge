# frozen_string_literal: true

require 'test_helper'

class PassswordMailerTest < ActionMailer::TestCase
  test 'reset' do
    mail = PassswordMailer.reset
    assert_equal 'Reset', mail.subject
    assert_equal ['to@example.org'], mail.to
    assert_equal ['from@example.com'], mail.from
    assert_match 'Hi', mail.body.encoded
  end
end
