class RepopMigration < ActiveRecord::Migration
  def self.up
    create_table :repops do |t|
      t.references :repopsable, :polymorphic => true
      t.string :context
      t.string :key
      t.string :value

      t.timestamps
    end

    add_index :options, [:repop_id, :context]
  end

  def self.down
    drop_table :repops
  end
end
