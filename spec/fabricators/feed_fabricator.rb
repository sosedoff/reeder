Fabricator(:feed) do
  title 'Blog'
  description 'Some blog description'
  site_url 'http://foo.com'
  url 'http://foo.com/rss.xml' 
  last_modified_at Time.now
end