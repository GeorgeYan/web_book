class AddCourseIdToModifyparagraph < ActiveRecord::Migration
  def change
    add_column :modifyparagraphs, :course_id, :integer
  end
end
