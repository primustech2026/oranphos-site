ARTICLE_EXCLUSIONS = %w[import-checklist.html tank-mix-chart.html solubility-card.html].freeze
BANNED = [
  "comprehensive", "robust", "leverage", "cutting-edge", "game-changer",
  "revolutionize", "delve into", "in today's", "in the world of", "when it comes to"
].freeze

def visible_text(html)
  html
    .gsub(/<script.*?<\/script>/m, " ")
    .gsub(/<style.*?<\/style>/m, " ")
    .gsub(/<[^>]+>/, " ")
    .gsub(/&[a-zA-Z0-9#]+;/, " ")
end

Dir[File.expand_path("../resources/*.html", __dir__)].sort.each do |file|
  next if ARTICLE_EXCLUSIONS.include?(File.basename(file))

  html = File.read(file)
  article = html[/<article class="article-body">(.*?)<\/article>/m, 1].to_s
  text = visible_text(article)
  word_count = text.scan(/[A-Za-z0-9][A-Za-z0-9%₂₅₄₃⁻–—.\/-]*/).length
  first_h2 = article[/<h2[^>]*>(.*?)<\/h2>/m, 1].to_s.gsub(/<[^>]+>/, " ")
  direct = article[/<p class="direct-answer">(.*?)<\/p>/m, 1].to_s
  direct_count = visible_text(direct).scan(/[A-Za-z0-9][A-Za-z0-9%₂₅₄₃⁻–—.\/-]*/).length
  body_links = article.scan(/href="\.\.\/products-mkp\.html"/).length
  banned_hits = BANNED.select { |term| text.downcase.include?(term) }
  heading_hits = html.scan(/<h[12][^>]*>(.*?)<\/h[12]>/m).flatten.map { |h| visible_text(h) }.select { |h| h.match?(/MKP (supplier|manufacturer)/i) }

  puts [
    File.basename(file),
    "words=#{word_count}",
    "direct=#{direct_count}",
    "body_product_links=#{body_links}",
    "first_h2=#{first_h2.strip.inspect}",
    "banned=#{banned_hits.inspect}",
    "heading_bans=#{heading_hits.inspect}"
  ].join(" | ")
end
