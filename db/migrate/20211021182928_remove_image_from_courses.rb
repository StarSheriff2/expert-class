class RemoveImageFromCourses < ActiveRecord::Migration[6.1]
  def change
    remove_column :courses, :image, :string
  end
end
