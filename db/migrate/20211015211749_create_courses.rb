class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.string :instructor
      t.integer :duration
      t.string :image

      t.timestamps
    end
  end
end
