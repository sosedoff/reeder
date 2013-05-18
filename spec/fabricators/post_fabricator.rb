Fabricator(:post) do
  title        { sequence(:title) { |i| "Post #{i}" } }
  author       "Author Name"
  url          { sequence(:title) { |i| "http://foo.com/post/#{i}" } }
  content      "Post Message"
  published_at { Time.mktime(2013, 01, 01) }
end