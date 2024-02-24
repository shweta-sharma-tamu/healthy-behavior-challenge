# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/passsword_mailer
class PassswordMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/passsword_mailer/reset
  def reset
    PassswordMailer.reset
  end
end
