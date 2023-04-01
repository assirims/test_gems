class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  Sentry.capture_message("test message")
end
