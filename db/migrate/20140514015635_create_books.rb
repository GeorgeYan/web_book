class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :author_id
      t.integer :publish_corporation_id
      t.string :name
      t.string :language
      t.integer :translator_id
      t.integer :publish_time
      t.string :isbn
      t.string :type

      t.timestamps
    end
  end
end
