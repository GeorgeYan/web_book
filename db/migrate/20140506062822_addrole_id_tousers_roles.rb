class AddroleIdTousersRoles < ActiveRecord::Migration
  def change
    add_column :users_roles, :role_id, :integer
  end
end
