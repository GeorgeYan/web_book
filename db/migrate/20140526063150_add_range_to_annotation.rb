class AddRangeToAnnotation < ActiveRecord::Migration
  def change
    add_column :annotations, :start, :integer
    add_column :annotations, :end, :integer
  end
end
