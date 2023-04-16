# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.example.com"
SitemapGenerator::Sitemap.compress = false

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
