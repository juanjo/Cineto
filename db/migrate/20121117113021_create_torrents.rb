class CreateTorrents < ActiveRecord::Migration
  def self.up
    create_table :torrents do |t|
      t.integer :torrent_id, :null => false
      t.datetime :added_at, :null => false
      t.boolean :is_finished, :default => false
      t.string :name, :null => false
      t.decimal :download_rate, :default => 0
      t.integer :size, :null => false
      t.decimal :percent_done, :default => 0
      t.string :uri, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :torrents
  end
end
