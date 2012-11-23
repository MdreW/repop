class RepopMigration < ActiveRecord::Migration
  def self.up
    create_table :repkeys do |t|
      t.string :name
    end

    create_table :options do |t|
      t.references :repkey

      t.references :opzionable, :polymorphic => true

      t.string :context
      t.string :value

      t.timestamps
    end

    add_index :options, :repkey_id
    add_index :options, [:option_id, :context]
  end

  def self.down
    drop_table :taggings
    drop_table :tags
  end
end
