class ApplicationMailer < ActionMailer::Base
  default from: "${{secrets.PROJECT_MAILID}}"
  layout "mailer"
end
