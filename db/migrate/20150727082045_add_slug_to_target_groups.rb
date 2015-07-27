class AddSlugToTargetGroups < ActiveRecord::Migration
  def change
    add_column :target_groups, :slug, :string, index: true
    add_column :target_groups, :suggested_url, :string
  end
end
