class AddCompletedToTasks < ActiveRecord::Migration[8.1]
  def change
<<<<<<< HEAD
    add_column :tasks, :completed, :boolean, default: false
=======
    add_column :tasks, :completed, :boolean
>>>>>>> 5b163aa6e6941f9a781ae5b3d87ca2d72762c5dc
  end
end
