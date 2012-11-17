class Torrent < ActiveRecord::Base
  attr_protected nil

  def self.create_torrent(uri)
    id = TorrentApi.client.add_torrent(uri)

    Torrent.create!(
      :external_id => id
    )
  end
end
