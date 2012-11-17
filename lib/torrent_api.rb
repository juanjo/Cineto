FIELDS = [ "id", "name", "totalSize", "addedDate", "isFinished", "rateDownload", "rateUpload", "percentDone" ]

class TorrentApi
  def self.client
    @client ||= TorrentApi::Client.new( APP_CONFIG[:torrent_api] )
  end
end

class TorrentApi::Client
  def initialize(api_url)
    puts "XXX: api_url: #{api_url}"
    @api_url = api_url
    @session_id = get_session_id
  end

  def all
    puts "XXX: get_torrents"
    response =
      HTTParty.post(
        @api_url,
        :body =>
          {
            :method => "torrent-get",
            :arguments => {
              :fields => FIELDS
            }
          }.to_json,
        :headers => { "x-transmission-session-id" => @session_id }
      )
    puts "XXX: response: #{response}"

    puts "XXX: response[arguments][torrents]: #{response["arguments"]["torrents"]}"

    response_struct = RecursiveOpenStruct.new( response["arguments"], :recurse_over_arrays => true ).torrents



    puts "XXX: response_struct: #{response_struct}"
    puts "XXX: response_struct: #{response_struct.first}"

    puts "XXX:"
    puts "XXX: keys: #{response_struct.first.keys} "

    response_struct
  end

  def find(id)
    puts "XXX: get_torrent: #{id}"
    response =
      HTTParty.post(
        @api_url,
        :body =>
          {
            :method => "torrent-get",
            :arguments => {
              :fields => FIELDS,
              :ids => [id]
            }
          }.to_json,
        :headers => { "x-transmission-session-id" => @session_id }
      )

    puts "XXX: response: #{response}"

    response_struct = RecursiveOpenStruct.new( response["arguments"], :recurse_over_arrays => true ).torrents.first
  end

  def get_session_id
    puts "XXX: get_session_id: #{@api_url}"
    response = HTTParty.get(@api_url)
    result = response.headers["x-transmission-session-id"]
    puts "XXX: session_id: #{result}"
    result
  end

  def create(filename)
    puts "XXX: add_torrent: #{filename}"

    response =
      HTTParty.post(
        @api_url,
        :body =>
          {
            :method => "torrent-add",
            :arguments => {
              :filename => filename,
              :pause => true
            }
          }.to_json,
        :headers => { "x-transmission-session-id" => @session_id }
      )

    puts "XXX: response: #{response}"

    puts "XXX: response[arguments][torrent_added]: #{response["arguments"]["torrent-added"]}"

    response_struct = RecursiveOpenStruct.new( response["arguments"]["torrent-added"] )
    puts "XXX: response_struct: #{response_struct.id}"

    response_struct
  end

  def destroy(id)
    puts "XXX: remove_torrent: #{id}"

    response =
      HTTParty.post(
        @api_url,
        :body =>
          {
            :method => "torrent-remove",
            :arguments => {
              :ids => [id],
              :"delete-local-data" => true
            }
          }.to_json,
        :headers => { "x-transmission-session-id" => @session_id }
      )

    puts "XXX: response: #{response}"

    puts "XXX: response[arguments][torrent_added]: #{response["arguments"]["torrent-added"]}"

    response_struct = RecursiveOpenStruct.new( response["arguments"]["torrent-added"] )
    puts "XXX: response_struct: #{response_struct.id}"

    response_struct
  end
end

# puts "XXX: torrents: #{Torrent.new.get_torrents}"
# puts "XXX: torrents: #{Torrent.new.get_torrent(1)}"
# puts "XXX: torrents: #{Torrent.new.add_torrent("magnet:?xt=urn:btih:3e16157f0879eb43e9e51f45d485feff90a77283&dn=Ubuntu+10.04+LTS+x32&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A80&tr=udp%3A%2F%2Ftracker.publicbt.com%3A80&tr=udp%3A%2F%2Ftracker.istole.it%3A6969&tr=udp%3A%2F%2Ftracker.ccc.de%3A80")}"