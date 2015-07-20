class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.date :date
      t.text :summary
      t.string :image
      t.text :content
      t.string :slug
      t.string :suggested_url
      t.boolean :display, default: true

      t.timestamps null: false
    end
  end
end
