class Torrent < OpenStruct
  def self.parse_all( api_torrents )
    api_torrents.map { |api_torrent| Torrent.parse( api_torrent ) }.reverse
  end

  def self.parse( api_torrent )
    Torrent.new(
      :torrent_id => api_torrent["id"],
      :name => api_torrent["name"],
      :added_at => Time.at( api_torrent["addedDate"] ),
      :is_finished? => api_torrent["isFinished"],
      :percent_done => api_torrent["percentDone"] * 100,
      :rate_download => api_torrent["rateDownload"],
      :rate_upload => api_torrent["rateUpload"],
      :size => api_torrent["totalSize"],
      :files => Torrent.parse_files( api_torrent["files"] )
    )
  end

  def self.parse_files( api_files )
    api_files.map{ |api_file| Torrent.parse_file( api_file )}
  end

  def self.parse_file( api_file )
    OpenStruct.new(
      :bytes_completed => api_file["bytesCompleted"],
      :size => api_file["length"],
      :name => api_file["name"],
      :is_video? => is_video?( api_file["name"] )
    )
  end

  def self.is_video?( file_name )
    !!(file_name =~ /(avi|mp4|mkv|mov)$/)
  end


  def to_partial_path
    "torrent"
  end
end