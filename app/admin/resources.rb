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
  
  # Customize the form for editing and adding resources


# Alex notes:
# has_many_through attribute for tags and resources
# register tags on active admin
# register model (command line): $> rails generate active_admin:resource [MyModelName]

# Customize the form for editing and adding resources
  form do |f|
    f.inputs do
      f.input :title, label: 'Fund Name'
      f.input :description, label: 'Description'
      # Also update permit_params above
      # f.input :requirements, label: 'Requirements'
      # f.input :criteria, label: 'Criteria'
      f.input :amount, label: 'Amount'
      f.input :source, label: 'Department'
      f.input :contact_person, label: 'Fund Owner'
      f.input :email, label: 'Email'
      f.input :web, label: 'Website'
      f.input :tags, label: 'Tags', as: :check_boxes
      f.input :approved, label: 'Approved'
    end
    f.actions
  end

 


# Customize columns displayed on the index screen in the table
  index do
    selectable_column
    column 'Approved', :approved
    column 'Fund Name', :title
    column 'Fund Owner', :contact_person
    column 'Department', :source
    column :created_at
    column :updated_at
    actions
  end
 

  # Customize filters displayed on the left of the resources
  filter :contact_person, label: 'Fund Owner', as: :select
  filter :source, label: 'Department', as: :select
  filter :approved, label: 'Approved', as: :check_boxes
  filter :title, label: 'Fund Name'
  filter :created_at
  filter :updated_at
  filter :description, label: 'Description'
  # filter :requirements, label: 'Requirements'
  # filter :criteria, label: 'Criteria'
  filter :web, label: 'Website'
  filter :email, label: 'Email'
  filter :tags, label: 'Tags', as: :check_boxes
 
  config.sort_order = 'approved_desc'
  
end