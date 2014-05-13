class CreateUsersRoles < ActiveRecord::Migration
  def change
    create_table :users_roles do |t|

      t.timestamps
    end
  end
end
