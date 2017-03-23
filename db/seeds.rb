require 'ruby-instagram-scraper'

Post.destroy_all

def scrape(search)
  results = RubyInstagramScraper.get_user_media_nodes(search)
  results = results.map { |x| [x["display_src"], x["caption"]] }
  results.each_with_index do |result, idx|
    post = Post.new(caption: result[1])
    open("temp.jpg", 'wb') do |file|
      file << open(result[0]).read
      post.post_image = file
    end
    post.save
  end
end

ENV["instagram_names"].split(" ").each do |name|
  scrape(name)
end
