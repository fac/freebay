module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :success then "ui green message"
    when :error then "ui red message"
    when :notice then "ui blue message"
    end
  end

  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

  def listing_conditon_tag(listing)
    link_to(listing.condition, "#", {class: "ui green label" })
  end
end
