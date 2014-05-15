class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :teacher_book_id
      t.integer :start_time
      t.integer :end_time
      t.string :secrectkey
      t.string :ctype
      t.string :name

      t.timestamps
    end
  end
end
