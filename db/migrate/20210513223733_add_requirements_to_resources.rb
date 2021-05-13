class AddRequirementsToResources < ActiveRecord::Migration[6.0]
  def change
    add_column :resources, :requirements, :text
  end
end
