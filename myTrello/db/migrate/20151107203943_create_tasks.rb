class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title,           null: false
      t.string :description
      t.integer :duration,       null: false
      t.date :start_date,        null: false
      t.date :due_date,          null: false
      t.boolean :finished,        default: false
      t.references :user, index: true

      t.timestamps
    end
  end
end
