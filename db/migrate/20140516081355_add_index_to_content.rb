class AddIndexToContent < ActiveRecord::Migration
  def change
    add_column :contents, :index, :integer
  end
end
