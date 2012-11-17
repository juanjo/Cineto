FIELDS = [ "id", "name", "totalSize", "addedDate", "isFinished", "rateDownload", "rateUpload", "percentDone", "files" ]

class TorrentApi
  def self.client
    @client ||= TorrentApi::Client.new( APP_CONFIG[:torrent_api] )
  end
end

class TorrentApi::Client
  def initialize(api_url)
    puts "XXX: api_url: #{api_url}"
    @api_url = api_url
    @session_id = "unknown"
  end

  def all
    puts "XXX: get_torrents"

    response =
      post(
        :method => "torrent-get",
        :arguments => {
          :fields => FIELDS
        }
      )

    RecursiveOpenStruct.new( response["arguments"], :recurse_over_arrays => true ).torrents
  end

  def find(id)
    puts "XXX: get_torrent: #{id}"
    response =
      post(
        :method => "torrent-get",
        :arguments => {
          :fields => FIELDS,
          :ids => [id]
        }
      )

    RecursiveOpenStruct.new( response["arguments"], :recurse_over_arrays => true ).torrents.first
  end

  def create(filename)
    puts "XXX: add_torrent: #{filename}"

    response =
      post(
        :method => "torrent-add",
        :arguments => {
          :filename => filename,
          :pause => true
        }
      )

    RecursiveOpenStruct.new( response["arguments"]["torrent-added"] )
  end

  def destroy(id)
    puts "XXX: remove_torrent: #{id}"

    response =
      post(
        :method => "torrent-remove",
        :arguments => {
          :ids => [id],
          :"delete-local-data" => true
        }
      )

    RecursiveOpenStruct.new( response["arguments"]["torrent-added"] )
  end

  def post(opts)
    response =
      HTTParty.post(
        @api_url,
        :body => opts.to_json,
        :headers => { "x-transmission-session-id" => @session_id }
      )

    puts "XXX: response.body: #{response.body}"
    puts "XXX: response.code: #{response.code}"
    puts "XXX: response.message: #{response.message}"
    puts "XXX: response.headers: #{response.headers.inspect}"

    if( response.code == 409 )
      @session_id = response.headers["x-transmission-session-id"]
      response = post(opts)
    end

    response
  end
end

# puts "XXX: torrents: #{Torrent.new.get_torrents}"
# puts "XXX: torrents: #{Torrent.new.get_torrent(1)}"
# puts "XXX: torrents: #{Torrent.new.add_torrent("magnet:?xt=urn:btih:3e16157f0879eb43e9e51f45d485feff90a77283&dn=Ubuntu+10.04+LTS+x32&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A80&tr=udp%3A%2F%2Ftracker.publicbt.com%3A80&tr=udp%3A%2F%2Ftracker.istole.it%3A6969&tr=udp%3A%2F%2Ftracker.ccc.de%3A80")}"