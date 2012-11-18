

module TransmissionApiWrapper
  TORRENT_FIELDS = [
    "id",
    "name",
    "totalSize",
    "addedDate",
    "isFinished",
    "rateDownload",
    "rateUpload",
    "percentDone",
    "files"
  ]

  def self.client
    @client ||=
      TransmissionApi.new(
        :username => "username",
        :password => "password",
        :url      => "http://127.0.0.1:9091/transmission/rpc",
        :fields   => TORRENT_FIELDS
      )
  end
end