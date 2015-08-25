class AddCategoryToSubCategory < ActiveRecord::Migration
  def change
    add_reference :sub_categories, :category, index: true, foreign_key: true
  end
end
