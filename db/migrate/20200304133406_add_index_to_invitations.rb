class AddIndexToInvitations < ActiveRecord::Migration[5.2]
  def change
    add_index :invitations, [:inviter_id, :invited_id, :event_id], unique: true
  end
end
