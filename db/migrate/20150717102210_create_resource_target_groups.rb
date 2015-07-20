class CreateResourceTargetGroups < ActiveRecord::Migration
  def change
    create_table :resource_target_groups do |t|
      t.belongs_to :resource, index: true, foreign_key: true
      t.belongs_to :target_group, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
