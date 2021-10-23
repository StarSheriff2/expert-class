class AddColumnToCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :course_image_url, :string
  end
end
