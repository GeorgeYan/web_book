class AdduserIdTousersRoles < ActiveRecord::Migration
  def change
    add_column :users_roles, :user_id, :integer
  end
end
