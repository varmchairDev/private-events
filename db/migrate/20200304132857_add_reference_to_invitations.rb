class AddReferenceToInvitations < ActiveRecord::Migration[5.2]
  def change
    add_reference :invitations, :event, foreign_key: true
  end
end
