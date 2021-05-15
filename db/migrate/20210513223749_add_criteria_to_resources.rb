class AddCriteriaToResources < ActiveRecord::Migration[6.0]
  def change
    add_column :resources, :criteria, :text
  end
end
