class Torrent < ActiveRecord::Base
  attr_accessible :torrent_id, :added_at, :is_finished, :namd, :download_rate, :size, :percent_done
end
