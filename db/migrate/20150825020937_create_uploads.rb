class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :name
      t.text :description
      t.float :price
      t.string :url
      t.string :status

      t.timestamps null: false
    end
  end
end
