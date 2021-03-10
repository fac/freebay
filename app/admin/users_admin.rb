Trestle.resource(:users) do
  menu do
    item :users, icon: "fa fa-user-circle-o"
  end

  collection do
    # Set the default order when manual sorting is not applied
    User.order(first_name: :asc)
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :id
    column :email
    column :first_name
    column :last_name
    column :admin

    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |user|
    text_field :email
    text_field :first_name
    text_field :last_name
    check_box :admin
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:user).permit(:name, ...)
  # end
end
