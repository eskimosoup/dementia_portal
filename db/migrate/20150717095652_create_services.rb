class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name, null: false
      t.boolean :display, default: true

      t.timestamps null: false
    end
  end
end
