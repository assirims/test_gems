class ApplicationMailer < ActionMailer::Base
  default from: "Hostname <support@hostname.com>"
  layout "mailer"
end
