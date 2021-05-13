ActiveAdmin.register Resource do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :description, :amount, :source, :cp
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :amount, :source, :cp]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  #Definining the various categories for each resource
  # add parameters to forms. We use strong params to prevent people from making
  # themselves an admin by defining an admin bool 
  # https://activeadmin.info/2-resource-customization.html
  
  
  permit_params :title, :description, :amount, :source, :contact_person, :web, :approved, :email, tag_ids: []
  
  
  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :amount
      f.input :source
      f.input :contact_person
      f.input :email
      f.input :web
      f.input :tags, as: :check_boxes
      f.input :approved

      # there is a connection between resources and tags
    end
    f.actions
    
  end
  
    filter :contact_person, as: :select
    filter :source, as: :select
    filter :approved, as: :check_boxes
    filter :title
    filter :created_at
    filter :updated_at
    filter :description
    filter :web
    filter :email
    filter :tags, as: :check_boxes
 
  config.sort_order = 'approved_desc'
  
  # Customize columns displayed on the index screen in the table
  index do
    column :approved
    column :title
    column :contact_person
    column :email
    column :created_at
    column :updated_at
    actions
    # column "Approved", sortable: :approved do |resource|
  end

end

# Alex notes:
# has_many_through attribute for tags and resources
# register tags on active admin
# register model (command line): $> rails generate active_admin:resource [MyModelName]