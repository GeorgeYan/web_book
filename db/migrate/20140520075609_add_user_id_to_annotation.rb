class AddUserIdToAnnotation < ActiveRecord::Migration
  def change
    add_column :annotations, :user_id, :integer
    add_column :annotations, :course_id, :integer
  end
end
