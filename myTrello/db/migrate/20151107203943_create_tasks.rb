class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title,           null: false
      t.string :description,     null: false
      t.time :duration,          null: false
      t.date :start_date,        null: false
      t.date :end_date,          null: false
      t.boolean :checked,        default: false
      t.references :user, index: true

      t.timestamps
    end
  end
end
