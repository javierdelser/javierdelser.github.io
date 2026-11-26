#!/usr/bin/env ruby
# frozen_string_literal: true

# Build assets/pdf/Javier_Del_Ser_Full_CV.pdf: the complete CV, i.e. every professional section of the
# website in a single document. Photos, logos, maps, charts and the personal "Life & Sport" page are left out.
#
# Sources:
#   - _data/cv.yml                 experience, education, accreditations, research stays, languages
#   - _bibliography/papers.bib     complete publication list (full author lists)
#   - _data/preprints.yml          manuscripts under review
#   - _site/**/index.html          every other section, taken from the built website
#
# Usage (from the repository root):
#   ruby bin/make_full_cv_pdf.rb               # builds the site, writes the HTML and prints it to PDF with Chrome
#   ruby bin/make_full_cv_pdf.rb --no-build    # reuse the current _site/ (run `bundle exec jekyll build` first)
#   ruby bin/make_full_cv_pdf.rb --html-only   # only write the intermediate HTML (path is printed)
#
# Requires the site's gems (bundle install) and Google Chrome / Chromium on PATH.

ROOT = File.expand_path("..", __dir__)
ENV["BUNDLE_GEMFILE"] ||= File.join(ROOT, "Gemfile")
require "bundler/setup"
require "bibtex"
require "cgi"
require "date"
require "nokogiri"
require "tmpdir"
require "yaml"

SITE = File.join(ROOT, "_site")
BASE_URL = "https://javierdelser.github.io"
OUT_PDF = File.join(ROOT, "assets", "pdf", "Javier_Del_Ser_Full_CV.pdf")
ME = "Del Ser"

def esc(s) = CGI.escapeHTML(s.to_s)

# Very small markdown subset used in _data/cv.yml: **bold**, _italic_ and [text](url).
def md(s)
  esc(s)
    .gsub(/\*\*(.+?)\*\*/, '<b>\1</b>')
    .gsub(/(?<![\w\/])_(.+?)_(?!\w)/, '<i>\1</i>')
    .gsub(/\[(.+?)\]\((.+?)\)/, '<a href="\2">\1</a>')
end

def squish(s) = s.to_s.gsub(/\s+/, " ").strip

# Text of a node with <br> treated as a space.
def text_of(node)
  copy = node.dup
  copy.css("br").each { |b| b.replace(" ") }
  squish(copy.text)
end

# ---------------------------------------------------------------------------------------------------
# Website pages
# ---------------------------------------------------------------------------------------------------

def load_page(path)
  file = File.join(SITE, path, "index.html")
  abort "Missing #{file}: build the site first (bundle exec jekyll build)" unless File.exist?(file)
  Nokogiri::HTML(File.read(file, encoding: "utf-8"))
end

# Removes everything that is not text content (images, figures, scripts, maps, icons, buttons, ...)
# and makes links absolute. Returns the cleaned node.
def clean!(node)
  node.css("script, style, noscript, canvas, svg, iframe, video, picture, figure, i.fa-solid, i.fa-brands, i.fa-regular, i.ai, " \
           "button, .hidden, .profile, .affiliation-logos, .social, .links, .badges, .caption, #collab-map, .bib-search").each(&:remove)
  # An image goes together with the small wrapper around it (credit line, logo strip, ...).
  node.css("img").each do |img|
    wrapper = img.ancestors.find { |a| a.element? && %w[div p a].include?(a.name) && squish(a.text).length < 160 }
    (wrapper && wrapper != node ? wrapper : img).remove
  end
  node.css("p, div").each { |e| e.remove if squish(e.text) =~ /\A(Photos?|Images?)(\s*\(.*?\))?:/ && squish(e.text).length < 160 }
  # Rows of statistics (Bootstrap columns) become a single line of text.
  node.css("div.row.text-center").each do |row|
    items = row.css("> div").map { |c| text_of(c) }.reject(&:empty?)
    row.replace(Nokogiri::XML::Node.new("p", node.document).tap { |p| p["class"] = "stats"; p.content = items.join("  ·  ") }) if items.any?
  end
  # Inline "chips" (lists of research areas) become a single line separated by dots.
  node.css("p").each do |p|
    chips = p.css("> span.chip")
    next if chips.empty?

    p.content = chips.map { |c| squish(c.text) }.join("  ·  ")
  end
  # References to the clippings (images) that are not part of the PDF.
  node.xpath(".//text()").each { |t| t.content = t.content.gsub(/\s*\(see the clipping above\)/, "") if t.content.include?("clipping above") }
  # Date-like table cells should not wrap.
  node.css("td").each { |td| td["class"] = "d" if squish(td.text) =~ /\A\d{4}(-\d{2}){0,2}(\s*[–-]\s*(\d{4}|present))?\z/ }
  node.css("a").each do |a|
    href = a["href"].to_s
    if href.start_with?("#") || href.empty?
      a.replace(a.children)
    elsif href.start_with?("/")
      a["href"] = BASE_URL + href
    end
    %w[target rel class role onclick].each { |k| a.remove_attribute(k) }
  end
  node.css("[class]").each { |e| e.remove_attribute("class") unless %w[stats d].include?(e["class"]) }
  node.css("[style], [id]").each { |e| e.remove_attribute("style"); e.remove_attribute("id") }
  # Drop wrappers left empty and headings left without content.
  3.times { node.css("div, p, span, li, ul, td").each { |e| e.remove if squish(e.text).empty? && e.css("br, hr").empty? } }
  node.css("h2, h3, h4").each do |h|
    nxt = h.next_element
    level = h.name[1].to_i
    h.remove if nxt.nil? || (nxt.name =~ /\Ah[2-4]\z/ && nxt.name[1].to_i <= level)
  end
  node
end

# Shift heading levels so that page sections sit below the PDF section title.
def demote!(node, by = 1)
  node.css("h1, h2, h3, h4, h5").each { |h| h.name = "h#{[h.name[1].to_i + by, 6].min}" }
  node
end

def page_article(path)
  article = load_page(path).at_css("div.post article")
  demote!(clean!(article))
  article.inner_html
end

def profile_html
  bio = load_page("").at_css("div.post article .clearfix")
  bio.css("p").each { |p| p.remove if squish(p.text).start_with?("More:") }
  demote!(clean!(bio), 2).inner_html
end

def research_html
  doc = load_page("research")
  article = doc.at_css("div.post article")
  areas = article.css("div.projects a[href]").map { |a| a["href"] }.grep(%r{\A/research/[^/]+/?\z}).uniq
  article.css("div.projects").each(&:remove)
  out = [clean!(article).inner_html]
  areas.each do |href|
    page = load_page(href.sub(%r{\A/}, ""))
    title = squish(page.at_css("h1.post-title")&.text)
    desc = squish(page.at_css("p.post-description")&.text)
    body = page.at_css("div.post article")
    # Keep the description of the line; its publication list is already part of the Publications section.
    cut = body.at_css("h2.bibliography-section")
    if cut
      cut.xpath("following-sibling::*").each(&:remove)
      cut.remove
    end
    out << "<h3>#{esc(title)}</h3>#{desc.empty? ? "" : "<p class='lead'>#{esc(desc)}</p>"}#{demote!(clean!(body), 2).inner_html}"
  end
  out.join
end

def software_html
  doc = load_page("repositories")
  article = doc.at_css("div.post article")
  repos = YAML.safe_load_file(File.join(ROOT, "_data", "repositories.yml"))
  list = Array(repos["github_repos"]).map { |r| "<li><a href='https://github.com/#{esc(r)}'>#{esc(r)}</a></li>" }
  holder = article.at_css("div.repositories")
  holder&.replace(Nokogiri::HTML.fragment("<ul class='repos'>#{list.join}</ul>"))
  demote!(clean!(article)).inner_html
end

def team_html
  doc = load_page("team")
  article = doc.at_css("div.post article")
  article.css("blockquote").each { |b| b.remove if b.text.include?("Prospective students") }
  demote!(clean!(article)).inner_html
end

# ---------------------------------------------------------------------------------------------------
# CV data (_data/cv.yml)
# ---------------------------------------------------------------------------------------------------

def daterange(e)
  s, t = e["start_date"], e["end_date"]
  return e["date"].to_s.split("-").first.to_s unless s

  s = s.to_s.split("-").first
  t = t.nil? || t.to_s == "present" ? "present" : t.to_s.split("-").first
  s == t ? s : "#{s}–#{t}"
end

def cv_sections(cv)
  s = cv["sections"]
  out = {}
  rows = s["Experience"].sort_by { |e| e["start_date"].to_s }.reverse.map do |e|
    hl = Array(e["highlights"]).map { |h| "<li>#{md(h)}</li>" }.join
    "<tr><td class='d'>#{daterange(e)}</td><td><b>#{esc(e["position"])}</b><br>#{esc(e["company"])}" \
      "#{e["location"] ? ", #{esc(e["location"])}" : ""}#{hl.empty? ? "" : "<ul>#{hl}</ul>"}</td></tr>"
  end
  out["Professional experience"] = "<table class='cv'>#{rows.join}</table>"
  rows = s["Education"].map do |e|
    hl = Array(e["highlights"]).map { |h| "<li>#{md(h)}</li>" }.join
    "<tr><td class='d'>#{daterange(e)}</td><td><b>#{esc(e["studyType"])} in #{esc(e["area"])}</b><br>#{esc(e["institution"])}" \
      "#{hl.empty? ? "" : "<ul>#{hl}</ul>"}</td></tr>"
  end
  out["Education"] = "<table class='cv'>#{rows.join}</table>"
  %w[Accreditations Research\ Stays].each do |t|
    out[t == "Research Stays" ? "Research stays" : t] =
      "<table class='cv'>#{s[t].map { |e| "<tr><td class='d'>#{esc(e["label"])}</td><td>#{md(e["details"])}</td></tr>" }.join}</table>"
  end
  out["Languages"] = "<p>#{s["Languages"].map { |l| "#{esc(l["name"])} (#{esc(l["summary"])})" }.join(" · ")}</p>"
  out
end

# ---------------------------------------------------------------------------------------------------
# Publications (_bibliography/papers.bib, _data/preprints.yml)
# ---------------------------------------------------------------------------------------------------

def plain(v) = squish(v.to_s.gsub(/[{}]/, "").gsub("\\&", "&").gsub("--", "–"))

def initials(first)
  first.to_s.split(/\s+/).map { |w| w.split("-").map { |p| p.empty? ? "" : "#{p[0]}." }.join("-") }.join(" ")
end

def names(list)
  return "" if list.nil?

  list.map do |n|
    if n.respond_to?(:last) && n.last
      last = plain([n.prefix, n.last].compact.join(" "))
      txt = "#{initials(plain(n.first))} #{last}#{n.suffix ? ", #{plain(n.suffix)}" : ""}".strip
      last == ME ? "<b>#{esc(txt)}</b>" : esc(txt)
    else
      esc(plain(n.to_s))
    end
  end.join(", ")
end

def entry_html(e)
  f = ->(k) { e.field?(k) ? plain(e[k]) : nil }
  title = esc(f.(:title))
  year = f.(:year)
  doi = f.(:doi)
  parts = []
  case e.type
  when :book
    parts << "#{names(e.editor)} (eds.). <i>#{title}</i>. #{esc(f.(:publisher))}, #{year}."
  when :incollection
    parts << "#{names(e.author)}. “#{title}”. In <i>#{esc(f.(:booktitle))}</i>" \
             "#{f.(:pages) ? ", pp. #{esc(f.(:pages))}" : ""}. #{f.(:publisher) ? "#{esc(f.(:publisher))}, " : ""}#{year}."
  when :inproceedings
    series = [f.(:series), f.(:volume)].compact.join(" ")
    parts << "#{names(e.author)}. “#{title}”. In <i>#{esc(f.(:booktitle))}</i>" \
             "#{series.empty? ? "" : " (#{esc(series)})"}#{f.(:pages) ? ", pp. #{esc(f.(:pages))}" : ""}, #{year}."
  else
    vol = f.(:volume) ? " #{esc(f.(:volume))}#{f.(:number) ? "(#{esc(f.(:number))})" : ""}" : ""
    parts << "#{names(e.author)}. “#{title}”. <i>#{esc(f.(:journal))}</i>#{vol}#{f.(:pages) ? ", #{esc(f.(:pages))}" : ""}, #{year}."
  end
  parts << " <span class='note'>#{esc(f.(:note))}.</span>" if f.(:note)
  parts << " DOI: <a href='https://doi.org/#{esc(doi)}'>#{esc(doi)}</a>" if doi
  parts << " <span class='award'>#{esc(f.(:award_name))}</span>" if f.(:award_name)
  "<li>#{parts.join}</li>"
end

def publications_html
  bib = BibTeX.open(File.join(ROOT, "_bibliography", "papers.bib"), filter: :latex)
  entries = bib.data.select { |e| e.is_a?(BibTeX::Entry) }
  order = entries.each_with_index.to_h
  sorted = ->(type) { entries.select { |e| e.type == type }.sort_by { |e| [-e.year.to_s.to_i, order[e]] } }

  doc = load_page("publications")
  stats = squish(doc.at_css("div.post div.row.text-center")&.css("> div")&.map { |c| text_of(c) }&.join("  ·  "))
  other_db = squish(doc.at_css("div.post p.text-muted.small")&.text)[/Other databases[^.]*\./]
  out = +""
  out << "<p class='stats'>#{esc(stats)}</p>" unless stats.empty?
  out << "<p>#{esc(other_db)} Profiles: <a href='https://scholar.google.com/citations?user=p_wY0zUAAAAJ'>Google Scholar</a> · " \
         "<a href='https://orcid.org/0000-0002-1260-9775'>ORCID 0000-0002-1260-9775</a> · <a href='https://dblp.org/pid/94/1127.html'>DBLP</a> · " \
         "<a href='https://www.scopus.com/authid/detail.uri?authorId=9737598300'>Scopus 9737598300</a> · " \
         "<a href='https://www.webofscience.com/wos/author/record/J-2187-2014'>Web of Science J-2187-2014</a>.</p>"

  preprints = YAML.safe_load_file(File.join(ROOT, "_data", "preprints.yml")) || []
  sections = [["Preprints under review", preprints.map do |p|
    authors = esc(p["authors"]).gsub("Javier Del Ser", "<b>Javier Del Ser</b>")
    "<li>#{authors}. “#{esc(p["title"])}”. <span class='note'>Under review.</span></li>"
  end]]
  sections += [["Journal articles", :article], ["Conference papers", :inproceedings], ["Book chapters", :incollection],
               ["Edited books", :book]].map { |t, type| [t, sorted.(type).map { |e| entry_html(e) }] }
  sections.each do |t, items|
    next if items.empty?

    out << "<h3>#{t} (#{items.size})</h3><ol class='pubs'>#{items.join}</ol>"
  end
  out
end

# ---------------------------------------------------------------------------------------------------
# Document
# ---------------------------------------------------------------------------------------------------

CSS = <<~CSS
  @page { size: A4; margin: 16mm 15mm 18mm;
    @bottom-left { content: "Javier Del Ser · Full CV"; font: 7.5pt 'Roboto', Arial, sans-serif; color: #888; }
    @bottom-right { content: counter(page) " / " counter(pages); font: 7.5pt 'Roboto', Arial, sans-serif; color: #888; } }
  body { font-family: 'Roboto', 'Helvetica Neue', Arial, sans-serif; font-size: 9.4pt; color: #222; line-height: 1.38; }
  h1 { font-size: 22pt; margin: 0; font-weight: 400; color: #111; }
  .label { font-size: 11pt; color: #0b5e8c; margin-top: 2px; }
  .contact { font-size: 8.6pt; color: #555; margin: 6px 0 4px; }
  .contact div { margin: 1px 0; }
  .generated { font-size: 8pt; color: #888; margin-bottom: 8px; }
  .toc { columns: 2; font-size: 9pt; margin: 4px 0 0; padding-left: 18px; }
  h2 { font-size: 12pt; color: #0b5e8c; border-bottom: 1px solid #0b5e8c; padding-bottom: 2px; margin: 18px 0 6px; font-weight: 500;
       text-transform: uppercase; letter-spacing: .04em; break-after: avoid; }
  h3 { font-size: 10.5pt; color: #0b5e8c; margin: 12px 0 4px; font-weight: 500; break-after: avoid; }
  h4 { font-size: 9.8pt; margin: 10px 0 3px; font-weight: 600; break-after: avoid; }
  h5, h6 { font-size: 9.4pt; margin: 8px 0 2px; font-weight: 600; break-after: avoid; }
  p { margin: 3px 0 5px; text-align: justify; }
  p.lead { font-style: italic; color: #444; }
  p.stats { text-align: left; color: #0b5e8c; font-weight: 500; }
  table { width: 100%; border-collapse: collapse; margin: 3px 0 8px; font-size: 8.8pt; }
  th { text-align: left; border-bottom: 1px solid #bbb; padding: 2px 4px; font-weight: 600; }
  td { vertical-align: top; padding: 2px 4px; border-bottom: 1px solid #eee; }
  table.cv td { border: 0; padding: 2px 0 4px; }
  td.d { white-space: nowrap; }
  table.cv td.d { width: 24mm; color: #555; padding-right: 6px; }
  ul, ol { margin: 2px 0 6px; padding-left: 18px; }
  li { margin-bottom: 2px; }
  ol.pubs li { margin-bottom: 3px; }
  blockquote { margin: 4px 0 8px; padding-left: 10px; border-left: 3px solid #0b5e8c; color: #333; font-style: italic; }
  .award { background: #0b5e8c; color: #fff; border-radius: 3px; padding: 0 4px; font-size: 7.8pt; white-space: nowrap; }
  .note { color: #a0522d; }
  a { color: #0b5e8c; text-decoration: none; overflow-wrap: anywhere; }
  tr, li, blockquote { break-inside: avoid; }
CSS

def build_html
  cv = YAML.safe_load_file(File.join(ROOT, "_data", "cv.yml"), permitted_classes: [Date])["cv"]
  cvs = cv_sections(cv)
  sections = [
    ["Profile", profile_html],
    ["Professional experience", cvs["Professional experience"]],
    ["Education", cvs["Education"]],
    ["Accreditations", cvs["Accreditations"]],
    ["Research stays", cvs["Research stays"]],
    ["Awards and distinctions", page_article("awards")],
    ["Research lines", research_html],
    ["Research projects, contracts and patents", page_article("projects")],
    ["Publications", publications_html],
    ["Research groups, supervision and collaborators", team_html],
    ["Teaching", page_article("teaching")],
    ["Talks, editorial work and professional service", page_article("service")],
    ["Software", software_html],
    ["Media and outreach", page_article("press")],
    ["News", page_article("news")],
    ["Languages", cvs["Languages"]],
  ]
  toc = sections.each_with_index.map { |(t, _), i| "<li><a href='#s#{i}'>#{esc(t)}</a></li>" }.join
  body = sections.each_with_index.map { |(t, html), i| "<h2 id='s#{i}'>#{esc(t)}</h2>#{html}" }.join
  header = <<~HTML
    <h1>#{esc(cv["name"])}</h1>
    <div class="label">#{esc(cv["label"])}</div>
    <div class="contact">
      <div>TECNALIA Research &amp; Innovation, Parque Científico y Tecnológico de Bizkaia, Astondo Bidea, Edificio 700, 48160 Derio (Bizkaia), Spain · javier.delser@tecnalia.com</div>
      <div>University of the Basque Country (EHU), Department of Mathematics, Barrio Sarriena s/n, 48940 Leioa (Bizkaia), Spain · javier.delser@ehu.eus</div>
      <div><a href="#{BASE_URL}">#{BASE_URL.sub("https://", "")}</a> · ORCID 0000-0002-1260-9775 · Google Scholar p_wY0zUAAAAJ · ResearcherID J-2187-2014</div>
    </div>
    <div class="generated">Complete CV generated from the website on #{Date.today.strftime("%-d %B %Y")}.</div>
    <ol class="toc">#{toc}</ol>
  HTML
  "<!doctype html><html lang='en'><head><meta charset='utf-8'><title>Full CV – #{esc(cv["name"])}</title>" \
    "<style>#{CSS}</style></head><body>#{header}#{body}</body></html>"
end

def main
  unless ARGV.include?("--no-build")
    ok = Bundler.with_unbundled_env { system("bundle", "exec", "jekyll", "build", chdir: ROOT, out: File::NULL) }
    abort "Jekyll build failed" unless ok
  end
  html_path = File.join(Dir.mktmpdir("fullcv"), "full_cv.html")
  File.write(html_path, build_html)
  if ARGV.include?("--html-only")
    puts html_path
    return
  end
  chrome = %w[google-chrome chromium chromium-browser].find { |c| system("which", c, out: File::NULL, err: File::NULL) }
  abort "Chrome/Chromium not found; HTML written to #{html_path}" unless chrome
  ok = system(chrome, "--headless=new", "--no-sandbox", "--disable-gpu", "--no-pdf-header-footer",
              "--print-to-pdf=#{OUT_PDF}", "file://#{html_path}", out: File::NULL, err: File::NULL)
  abort "Chrome failed to print #{html_path}" unless ok
  puts "Wrote #{OUT_PDF}"
end

main if $PROGRAM_NAME == __FILE__
