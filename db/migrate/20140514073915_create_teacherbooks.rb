class CreateTeacherbooks < ActiveRecord::Migration
  def change
    create_table :teacherbooks do |t|
      t.integer :book_id
      t.integer :teacher_id

      t.timestamps
    end
  end
end
