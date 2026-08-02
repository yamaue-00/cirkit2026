class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :subject
      t.string :title
      t.string :content
      t.date :deadline

      t.timestamps
    end
  end
end
