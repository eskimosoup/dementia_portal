class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :content
      t.string :image
      t.boolean :display, default: true
      t.string :slug
      t.string :suggested_url

      t.timestamps null: false
    end
  end
end
