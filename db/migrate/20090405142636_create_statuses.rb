class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.string :body
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :statuses
  end
end
