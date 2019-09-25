module Admin
  class ListingsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Listing.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Listing.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    def scoped_resource
     if params[:show_archived] == "true"
       resource_class.where(is_archived: true)
     else
      resource_class.where(is_archived: false)
     end
   end
 end
end
