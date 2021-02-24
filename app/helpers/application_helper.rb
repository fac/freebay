module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :success then "alert alert-success"
    when :error then "alert alert-danger"
    when :notice then "alert alert-primary"
    when :alert then "alert alert-danger"
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

  def listing_condition_tag(listing, options = {})
    content_tag :div, humanized_condition(listing.condition), class: "badge #{condition_colour(listing.condition)} #{options[:class]}"
  end

  def condition_colour(condition)
    {
      "good" => "bg-success",
      "poor" => "bg-warning",
      "average" => "bg-info",
      "requires_repair" => "be-danger"
    }.fetch(condition, "")
  end

  def listing_category_tag(listing, options = {})
    content_tag :div, humanized_category(listing.category), class: "badge bg-secondary #{options[:class]}"
  end
end
