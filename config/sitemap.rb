# Set the host name for URL creation
SitemapGenerator::Sitemap.compress = false
SitemapGenerator::Sitemap.default_host = "https://www.example.com"

# The remote host where your sitemaps will be hosted
SitemapGenerator::Sitemap.sitemaps_host = "https://remotehost.com/"

# SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(
#   "corsego-public",
#   aws_access_key_id: Rails.application.credentials.dig(:awss3, :access_key_id),
#   aws_secret_access_key: Rails.application.credentials.dig(:awss3, :secret_access_key),
#   aws_region: "eu-central-1"
# )

SitemapGenerator::Sitemap.create do
  # add '/home', :changefreq => 'daily', :priority => 0.9
  # add '/contact_us', :changefreq => 'weekly'
  add courses_path, priority: 0.7, changefreq: 'weekly'
  add tags_path, priority: 0.2, changefreq: 'monthy'

  add new_user_registration_path, priority: 0.8, changefreq: 'monthy'
  add new_user_session_path, priority: 0.8, changefreq: 'monthy'

  Course.where(published: true, approved: true).find_each do |course|
    add course_path(course), lastmod: course.updated_at
  end
  # SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks
end
