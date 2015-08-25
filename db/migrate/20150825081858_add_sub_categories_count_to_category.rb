class AddSubCategoriesCountToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :sub_categories_count, :integer, default: 0
    Category.find_each do |c|
      Category.reset_counters(c.id, :sub_categories)
    end
  end
end
