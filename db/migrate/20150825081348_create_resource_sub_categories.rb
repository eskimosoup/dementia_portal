class CreateResourceSubCategories < ActiveRecord::Migration
  def change
    create_table :resource_sub_categories do |t|
      t.belongs_to :resource, index: true, foreign_key: true
      t.belongs_to :sub_category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
