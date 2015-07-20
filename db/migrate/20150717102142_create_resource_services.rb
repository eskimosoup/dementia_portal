class CreateResourceServices < ActiveRecord::Migration
  def change
    create_table :resource_services do |t|
      t.belongs_to :resource, index: true, foreign_key: true
      t.belongs_to :service, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
