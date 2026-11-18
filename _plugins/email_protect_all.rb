# frozen_string_literal: true

# Site-level hardening for `protect_email: true`.
#
# al_email_protect only protects addresses rendered through its own tag/filter.
# The social-links block (mailto: link) and the CV contact table still emit the
# address in plain text, so this hook post-processes every rendered HTML page:
#   1. every mailto: anchor is rewritten by AlEmailProtect.rewrite_html;
#   2. any remaining plain-text address outside <script>/<style> blocks and tags
#      is replaced by the same click-to-copy markup (no user@host in the HTML).
module SiteEmailProtect
  ADDRESS = /\b([A-Za-z0-9._%+-]+)@([A-Za-z0-9-]+(?:\.[A-Za-z0-9-]+)+)\b/.freeze
  SKIP_BLOCK = %r{(<script\b.*?</script>|<style\b.*?</style>|<[^>]*>)}im.freeze

  SCRIPT_MAILTO = /(["'])mailto:([^"']+)\1/.freeze

  module_function

  def script_mailto(quote, target)
    parts = AlEmailProtect.split_address(AlEmailProtect.decode_target(target))
    return "#{quote}mailto:#{target}#{quote}" unless parts

    local, domain = parts
    "[#{quote}mailto:#{local}#{quote}, #{quote}#{domain}#{quote}].join(String.fromCharCode(64))"
  end

  def link(local, domain)
    %(<a href="#" class="al-email-protect" data-eu="#{AlEmailProtect.escape(local)}" data-ed="#{AlEmailProtect.escape(domain)}">) +
      %(<span class="al-email-text">#{AlEmailProtect.escape(local)}</span><span class="al-email-sep"> [at] </span>) +
      AlEmailProtect.domain_markup(domain) + "</a>"
  end

  def protect(html)
    html = AlEmailProtect.rewrite_html(html)
    html.split(SKIP_BLOCK).map do |chunk|
      # Inside scripts (e.g. the search index), split percent-encoded mailto: strings into halves.
      next chunk.gsub(SCRIPT_MAILTO) { script_mailto(Regexp.last_match(1), Regexp.last_match(2)) } if chunk.start_with?("<script")
      next chunk if chunk.start_with?("<")

      chunk.gsub(ADDRESS) { link(Regexp.last_match(1), Regexp.last_match(2)) }
    end.join
  end

  def process(doc)
    return unless defined?(AlEmailProtect) && AlEmailProtect.enabled?(doc.site)
    return unless doc.output_ext == ".html" && doc.output

    doc.output = protect(doc.output)
  end
end

Jekyll::Hooks.register [:pages, :documents], :post_render do |doc|
  SiteEmailProtect.process(doc)
end
