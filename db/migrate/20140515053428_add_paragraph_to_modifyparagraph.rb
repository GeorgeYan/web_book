class AddParagraphToModifyparagraph < ActiveRecord::Migration
  def change
    add_column :modifyparagraphs, :paragraph_id, :integer
  end
end
