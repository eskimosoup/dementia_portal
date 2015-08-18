class AddPageToTargetGroups < ActiveRecord::Migration
  def change
    add_reference :target_groups, :page, index: true, foreign_key: true
  end
end
