class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.date :date, null: false
      t.string :location, null: false

      t.timestamps
    end
  end
end
