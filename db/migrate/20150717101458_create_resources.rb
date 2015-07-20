class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name, null: false
      t.text :summary
      t.text :description
      t.string :url
      t.text :youtube_embed_code
      t.belongs_to :organisation, index: true, foreign_key: true
      t.string :date
      t.string :time
      t.text :venue
      t.string :postcode
      t.string :slug
      t.string :suggested_url
      t.boolean :display, default: true

      t.timestamps null: false
    end
  end
end
