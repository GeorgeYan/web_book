class AddUuidToAnnotation < ActiveRecord::Migration
  def change
    add_column :annotations, :uuid, :string
  end
end
