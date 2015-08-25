class DropResourceCategories < ActiveRecord::Migration
  def up
    drop_table :resource_categories
  end
  def down
    create_table :resource_categories do |t|
      t.belongs_to :resource, index: true, foreign_key: true
      t.belongs_to :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
