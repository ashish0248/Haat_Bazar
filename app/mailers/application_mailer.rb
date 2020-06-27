class ApplicationMailer < ActionMailer::Base
   default from:     "system@example.com",
          reply_to: "system@example.com"
  layout 'mailer'
end
