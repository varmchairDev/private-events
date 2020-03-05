class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.boolean :read_status
      t.integer :inviter_id
      t.integer :invited_id

      t.timestamps
    end 
  end
end
