ActiveAdmin.register Gutentag::Tag do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # 
  #
  # or
  #
  # permit_params do
  # permitted = [:name, :taggings_count]
  # permitted << :other if params[:action] == 'create' && current_user.admin?
  # permitted
  # end
  
 permit_params :name
  
  
  
end
