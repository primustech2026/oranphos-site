require "pathname"

root = File.expand_path("..", __dir__)
html_files = Dir[File.join(root, "**", "*.html")].reject do |file|
  file.include?("/.asset-audit/") ||
    file.include?("/docs/design-qa/") ||
    File.basename(file) == "oranphos_unified.html"
end

errors = []
expected_nav = %w[Home Products MKP\ 0-52-34 Technology Quality Resources About Contact]

html_files.each do |file|
  html = File.read(file)
  relative = Pathname.new(file).relative_path_from(Pathname.new(root)).to_s

  errors << "#{relative}: missing title" unless html.match?(/<title>[^<]+<\/title>/)
  errors << "#{relative}: missing meta description" unless html.match?(/<meta name="description" content="[^"]+"/)
  errors << "#{relative}: missing fixed COA bar" unless html.include?('class="fixed-coa"')
  errors << "#{relative}: missing WhatsApp control" unless html.include?('class="wa-float"')

  nav = html[/<nav class="nav">(.*?)<\/nav>/m, 1].to_s
  expected_nav.each do |label|
    errors << "#{relative}: nav missing #{label}" unless nav.include?(">#{label}<")
  end

  html.scan(/(?:href|src)="([^"]+)"/).flatten.each do |target|
    next if target.empty? || target.start_with?("#", "mailto:", "tel:", "javascript:", "http://", "https://")

    clean = target.split(/[?#]/, 2).first
    resolved =
      if clean.start_with?("/")
        File.join(root, clean.sub(%r{\A/+}, ""))
      else
        File.expand_path(clean, File.dirname(file))
      end
    errors << "#{relative}: dead local link #{target}" unless File.exist?(resolved)
  end
end

article_files = html_files.select { |file| File.read(file).include?('class="article-body"') }
article_files.each do |file|
  html = File.read(file)
  article = html[/<article class="article-body">(.*?)<\/article>/m, 1].to_s
  count = article.scan(/href="\.\.\/products-mkp\.html"/).length
  relative = Pathname.new(file).relative_path_from(Pathname.new(root)).to_s
  errors << "#{relative}: expected exactly 1 in-article products-mkp link, found #{count}" unless count == 1
end

if errors.empty?
  puts "PASS: #{html_files.length} HTML pages checked; all local links resolve and shared controls are present."
else
  warn errors.join("\n")
  exit 1
end
