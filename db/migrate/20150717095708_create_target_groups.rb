class CreateTargetGroups < ActiveRecord::Migration
  def change
    create_table :target_groups do |t|
      t.string :name, null: false
      t.boolean :display, default: true

      t.timestamps null: false
    end
  end
end
