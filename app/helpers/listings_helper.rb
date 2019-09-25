module ListingsHelper
  def humanized_end_time(listing)
    if listing.active?
      if listing.end_time > Time.now
        "Ends in #{distance_of_time_in_words(Time.now, listing.end_time)}"
      else
        "Ended"
      end
    else
      "Not Active"
    end
  end
end
