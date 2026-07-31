require "base64"
require "digest"
require "fileutils"

ROOT = File.expand_path("..", __dir__)
SOURCE = File.join(ROOT, "oranphos_unified.html")
HTML = File.binread(SOURCE).force_encoding("UTF-8")

FileUtils.mkdir_p(File.join(ROOT, "assets", "img"))
FileUtils.mkdir_p(File.join(ROOT, "assets"))

asset_names = %w[
  robot-palletizer.jpg
  crystal-macro.jpg
  aerial-plant.jpg
  hero-reactor.jpg
  process-vessels.jpg
  container-loading.jpg
  bag-filling.jpg
  fertigation-room.jpg
  team-export.jpg
  team-qc.jpg
  team-logistics.jpg
  qc-lab.jpg
  warehouse-scan.jpg
  qc-hands.jpg
  tomato-drip.jpg
  cert-iso9001.jpg
  cert-iso45001.jpg
  cert-halal-my.jpg
  cert-halal-mui.jpg
  product-bag.jpg
  crystal-wide.jpg
]

unique_assets = {}
asset_order = []
HTML.scan(/data:image\/([^;]+);base64,([^"]+)/m) do |type, encoded|
  data = Base64.decode64(encoded)
  sha = Digest::SHA256.hexdigest(data)
  next if unique_assets.key?(sha)

  unique_assets[sha] = { type: type, encoded: encoded, data: data }
  asset_order << sha
end

abort "Expected 21 unique embedded images, found #{asset_order.length}" unless asset_order.length == asset_names.length

asset_order.each_with_index do |sha, index|
  target = File.join(ROOT, "assets", "img", asset_names[index])
  File.binwrite(target, unique_assets.fetch(sha).fetch(:data))
end

source_with_assets = HTML.gsub(/data:image\/([^;]+);base64,([^"]+)/m) do
  data = Base64.decode64(Regexp.last_match(2))
  sha = Digest::SHA256.hexdigest(data)
  index = asset_order.index(sha)
  "assets/img/#{asset_names.fetch(index)}"
end

css = HTML[/<style>(.*?)<\/style>/m, 1]
File.write(File.join(ROOT, "assets", "site.css"), css.strip + "\n")

def slice_page(source, page_id, next_id = nil)
  opening = source.index(%(<div id="page-#{page_id}"))
  raise "Missing page #{page_id}" unless opening

  body_start = source.index(">", opening) + 1
  finish =
    if next_id
      source.index(%(<div id="page-#{next_id}"), body_start)
    else
      source.index("<footer>", body_start)
    end
  raise "Missing end marker for #{page_id}" unless finish

  fragment = source[body_start...finish]
  fragment = fragment.sub(/<\/div>\s*\z/, "")
  fragment
end

page_ids = %w[home mkp products quality contact]
next_ids = %w[mkp products quality contact]
fragments = {}
page_ids.each_with_index do |page_id, index|
  fragments[page_id] = slice_page(source_with_assets, page_id, next_ids[index])
end

def convert_links(fragment)
  routes = {
    "home" => "index.html",
    "mkp" => "products-mkp.html",
    "products" => "products.html",
    "quality" => "quality.html",
    "contact" => "contact.html"
  }
  routes.each do |id, file|
    fragment = fragment.gsub(/href="#" onclick="showPage\('#{id}'\);return false"/, %(href="#{file}"))
  end
  fragment
end

NAV_ITEMS = [
  ["home", "Home", "index.html"],
  ["products", "Products", "products.html"],
  ["mkp", "MKP 0-52-34", "products-mkp.html"],
  ["technology", "Technology", "technology.html"],
  ["quality", "Quality", "quality.html"],
  ["resources", "Resources", "resources.html"],
  ["about", "About", "about.html"],
  ["contact", "Contact", "contact.html"]
].freeze

def nav(active)
  links = NAV_ITEMS.map do |id, label, href|
    %( <a href="#{href}"#{id == active ? ' class="act"' : ""}>#{label}</a>)
  end.join
  <<~HTML
    <nav class="nav"><div class="nav-in">
      <a class="mark" href="index.html">ORAN<i>PHOS</i></a>
      <div class="nlinks">#{links}</div>
      <a class="ncta" href="contact.html">Request COA pack</a>
      <span class="langsw"><b>EN</b> · ES · AR</span>
    </div></nav>
  HTML
end

def footer
  <<~HTML
    <footer><div class="wrap">
      <div class="fgrid">
        <div><div class="fmark">ORAN<i>PHOS</i></div><p class="fdesc">Thermal-process phosphate manufacturer in Shaanxi, China.</p></div>
        <div class="fcol"><h4>Products</h4><a href="products.html">All products</a><a href="products-mkp.html">MKP 0-52-34</a><a href="technology.html">Thermal process</a></div>
        <div class="fcol"><h4>Company</h4><a href="about.html">About</a><a href="quality.html">Quality</a><a href="resources.html">Resources</a></div>
        <div class="fcol"><h4>Contact</h4><a href="mailto:sales@oranphos.com">sales@oranphos.com</a><a href="contact.html">Contact page</a></div>
      </div>
      <div class="fbot"><span>© 2026 ORANPHOS · Shaanxi, China</span><span>MKP 0-52-34 · HS 2835.24 · Made in China</span></div>
    </div></footer>
  HTML
end

def fixed_cta
  <<~HTML
    <aside class="fixed-coa" aria-label="COA request">
      <span>Request COA pack — reply &lt; 24h</span>
      <a class="btn btn-a" href="mailto:sales@oranphos.com?subject=10-lot%20COA%20pack%20request">Request pack</a>
    </aside>
    <a class="wa-float" href="contact.html" aria-label="Open WhatsApp contact options">WA</a>
  HTML
end

META = {
  "home" => ["ORANPHOS | Thermal-Process Phosphate Manufacturer in China", "ORANPHOS manufactures MKP, DKP, urea phosphate and thermal phosphoric acid in Shaanxi, China, with 70,000 t/y integrated capacity."],
  "mkp" => ["MKP 0-52-34 Manufacturer | ORANPHOS", "Greenhouse-grade MKP 0-52-34 with ≥99% assay, 0.07% water insolubles and 0.0014% chloride, supplied in 25 kg export bags."],
  "products" => ["Phosphate Products | ORANPHOS", "Explore ORANPHOS MKP, DKP, urea phosphate, thermal phosphoric acid, TSP and DSP from one integrated Shaanxi phosphate plant."],
  "quality" => ["Quality, COA and Batch Control | ORANPHOS", "Review ORANPHOS lot-level COA controls, water-insoluble records, test methods, retained samples and SGS inspection options."],
  "contact" => ["Contact ORANPHOS | Request COA and Phosphate Pricing", "Request a 10-lot COA pack, phosphate specifications, samples and FOB Shanghai or Qingdao pricing from ORANPHOS."]
}.freeze

FILES = {
  "home" => "index.html",
  "mkp" => "products-mkp.html",
  "products" => "products.html",
  "quality" => "quality.html",
  "contact" => "contact.html"
}.freeze

page_ids.each do |page_id|
  title, description = META.fetch(page_id)
  body = convert_links(fragments.fetch(page_id))
  document = <<~HTML
    <!doctype html>
    <html lang="en">
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>#{title}</title>
      <meta name="description" content="#{description}">
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@600;700&family=Source+Sans+3:wght@400;600;700&family=IBM+Plex+Mono:wght@500;600&display=swap" rel="stylesheet">
      <link rel="stylesheet" href="assets/site.css">
    </head>
    <body>
      #{nav(page_id)}
      <main>#{body}</main>
      #{footer}
      #{fixed_cta}
      <script src="assets/site.js"></script>
    </body>
    </html>
  HTML
  File.write(File.join(ROOT, FILES.fetch(page_id)), document)
end

puts "Extracted #{asset_order.length} images and generated #{page_ids.length} standalone pages."
