require "administrate/base_dashboard"

class ListingDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    title: Field::String,
    description: Field::Text,
    reserve_price: Field::String.with_options(searchable: false),
    starting_price: Field::String.with_options(searchable: false),
    start_time: Field::DateTime,
    is_archived: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    image_file_name: Field::String,
    image_content_type: Field::String,
    image_file_size: Field::Number,
    image_updated_at: Field::DateTime,
    end_time: Field::DateTime,
    image: Field::Paperclip,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :title,
    :description,
    :image,
    :is_archived,
    :updated_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :title,
    :description,
    :reserve_price,
    :starting_price,
    :start_time,
    :is_archived,
    :created_at,
    :updated_at,
    :end_time,
    :image,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :title,
    :description,
    :reserve_price,
    :starting_price,
    :start_time,
    :end_time,
    :is_archived,
    :image,
  ].freeze

  # Overwrite this method to customize how listings are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(listing)
  #   "Listing ##{listing.id}"
  # end
end
