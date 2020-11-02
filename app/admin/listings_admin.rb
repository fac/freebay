Trestle.resource(:listings) do
  menu do
    item :listings, icon: "fa fa-list-alt"
  end

  scopes do
    scope :active, -> { Listing.active }, default: true
    scope :all
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :id
    column :title
    column :description
    column :reserve_price
    column :starting_price
    column :is_archived
    column :start_time
    column :end_time
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |listing|
    text_field :title
    text_area :description

    text_field :reserve_price
    text_field :starting_price

    row do
      col(sm: 6) {datetime_field :start_time}
      col(sm: 6) {datetime_field :end_time}
    end

    file_field :image

    check_box :is_archived
    select :condition, Listing::CONDITION
    select :category, Listing::CATEGORIES
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:listing).permit(:name, ...)
  # end
end
