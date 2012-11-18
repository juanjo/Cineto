

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
        :username => APP_CONFIG[:transmission_auth]["username"],
        :password => APP_CONFIG[:transmission_auth]["password"],
        :url      => APP_CONFIG[:transmission_api_url],
        :fields   => TORRENT_FIELDS
      )
  end
end