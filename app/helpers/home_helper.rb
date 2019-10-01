module HomeHelper
  def humanized_category(category)
    return "" if category.nil?
    category.humanize.titleize.gsub("Iphone", "iPhone").gsub("Ipad", "iPad")
  end

  def humanized_condition(condition)
    return "" if condition.nil?
    condition.humanize.titleize
  end

  def categories_options_for_select
    (["all"] + Listing::CATEGORIES).map do |category|
      [humanized_category(category), category]
    end
  end

  def conditon_options_for_select
    (["all"] + Listing::CONDITION).map do |condition|
      [humanized_condition(condition), condition]
    end
  end
end
