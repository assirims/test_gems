source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# EDITOR="code --wait" rails credentials:edit

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4", ">= 7.0.4.2"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# drop table from rails console
# ActiveRecord::Migration.drop_table(:users)
# Use sqlite3 as the database for Active Record
# RAILS_ENV=production bundle exec rake db:create db:schema:load
gem "sqlite3", "~> 1.4"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
#sudo apt install imagemagick
# fix action_text displaying images, S3 bucket, work with action_text
gem "image_processing", "~> 1.2"
# https://github.com/igorkasyanchuk/active_storage_validations
gem "active_storage_validations", "~> 1.0"
# https://github.com/aws/aws-sdk-ruby
gem "aws-sdk-s3", "~> 1.120", require: false
# https://www.youtube.com/watch?v=2iGBuLQ3S0c
# https://blog.corsego.com/action-text-embed-youtube

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  gem "spring"

  # https://github.com/voormedia/rails-erd
  gem "rails-erd", "~> 1.7"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

# https://github.com/rails/cssbundling-rails
gem "cssbundling-rails", "~> 1.1"

# https://fontawesome.com/docs/web/use-with/ruby-on-rails
# https://blog.corsego.com/fontawesome-importmaps-rails7
gem "font-awesome-sass", "~> 6.3"

# https://github.com/faker-ruby/faker
gem "faker", "~> 3.1"

# https://github.com/norman/friendly_id
gem "friendly_id", "~> 5.5"

# https://github.com/activerecord-hackery/ransack
gem "ransack", "~> 4.0"

# https://github.com/heartcombo/devise
gem "devise", "~> 4.9"

# https://github.com/public-activity/public_activity
gem "public_activity", "~> 2.0"

# https://github.com/RolifyCommunity/rolify
gem "rolify", "~> 6.0"

# https://github.com/varvet/pundit
gem "pundit", "~> 2.3"

# https://github.com/heartcombo/simple_form
gem "simple_form", "~> 5.2"

# https://github.com/smartinez87/exception_notification
gem "exception_notification", "~> 4.5"

# https://github.com/ddnexus/pagy
gem "pagy", "~> 6.0"

# https://github.com/ankane/chartkick
# https://chartkick.com/
gem "chartkick", "~> 5.0"

# https://github.com/ankane/groupdate
gem "groupdate", "~> 6.2"

# Configure Rails SDK for Sentry
# https://docs.sentry.io/platforms/ruby/guides/rails/configuration/
# gem "sentry-ruby", "~> 5.8"
# gem "sentry-rails", "~> 5.8"

# https://github.com/brendon/ranked-model
gem "ranked-model", "~> 0.4.8"

# https://github.com/mileszs/wicked_pdf
gem "wicked_pdf", "~> 2.6"
# https://github.com/zakird/wkhtmltopdf_binary_gem
gem "wkhtmltopdf-binary", "~> 0.12.6", group: :development

# https://github.com/rposborne/wkhtmltopdf-heroku
gem "wkhtmltopdf-heroku", "~> 2.12", group: :production

# https://github.com/zombocom/wicked
#  rails g controller course_creater
gem "wicked", "~> 2.0"
