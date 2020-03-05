class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string   :name
      t.text     :description
      t.string   :event_type
      t.date     :event_start_at
      t.date     :event_end_at

      t.timestamps
    end
    add_index :events, :name, unique: true
    add_index :events, [:event_start_at, :event_end_at]
  end
end
