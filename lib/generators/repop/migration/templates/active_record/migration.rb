class RepopMigration < ActiveRecord::Migration
  def self.up
    create_table :repops do |t|
      t.references :repopable, :polymorphic => true
      t.string :key
      t.string :value

      t.timestamps
    end

    add_index :repops, :repopable_id
    add_index :repops, :repopable_type
  end

  def self.down
    drop_table :repops
  end
end
