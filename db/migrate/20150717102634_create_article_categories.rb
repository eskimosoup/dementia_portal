class CreateArticleCategories < ActiveRecord::Migration
  def change
    create_table :article_categories do |t|
      t.belongs_to :category, index: true, foreign_key: true
      t.belongs_to :article, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
