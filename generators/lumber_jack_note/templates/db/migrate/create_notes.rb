class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table  :notes do |t|
      t.string    :title
      t.string    :body
      t.integer   :notable_id
      t.string    :notable_type
      t.integer   :position
      t.integer   :created_by_user_id
      t.integer   :modified_by_user_id
      t.integer   :lock_version, :default => 0
      t.timestamps
    end
    add_index :notes, [:body, :title]
    add_index :notes, [:notable_type, :notable_id]
  end

  def self.down
    drop_table :notes
  end
end
