class DropResourceServices < ActiveRecord::Migration
  def up
    drop_table :resource_services
  end

  def down
    create_table :resource_services do |t|
      t.belongs_to :resource, index: true, foreign_key: true
      t.belongs_to :service, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
