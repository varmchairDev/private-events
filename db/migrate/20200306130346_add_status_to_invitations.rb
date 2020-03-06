class AddStatusToInvitations < ActiveRecord::Migration[5.2]
  def change
    add_column :invitations, :rejected, :boolean, default: false
    add_column :invitations, :accepted, :boolean, default: false 
  end
end
