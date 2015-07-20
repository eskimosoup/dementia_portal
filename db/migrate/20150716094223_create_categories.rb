class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title, null: false
      t.string :slug, index: true
      t.string :suggested_url
      t.string :image
      t.boolean :display, default: true
      t.boolean :display_on_home, default: true
      t.integer :position, default: 0

      t.timestamps null: false
    end
  end
end
