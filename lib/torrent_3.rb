require "httparty"
require "json"

BASE_URL = "http://localhost:9091/transmission/rpc"
FIELDS = [ "id", "name", "totalSize", "status" ]

class Torrent
  def initialize
    @session_id = get_session_id
  end

  def get_torrents
    puts "XXX: get_torrents"
    response =
      HTTParty.post(
        BASE_URL,
        :body =>
          {
            :method => "torrent-get",
            :arguments => {
              :fields => FIELDS
            }
          }.to_json,
        :headers => { "x-transmission-session-id" => @session_id }
      )
  end

  def get_torrent(id)
    puts "XXX: get_torrent: #{id}"
    response =
      HTTParty.post(
        BASE_URL,
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

  end

  def get_session_id
    response = HTTParty.get(BASE_URL)
    result = response.headers["x-transmission-session-id"]
    puts "XXX: session_id: #{result}"
    result
  end

  def add_torrent(filename)
    puts "XXX: add_torrent: #{filename}"

    response =
      HTTParty.post(
        BASE_URL,
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

  end
end

# puts "XXX: torrents: #{Torrent.new.get_torrents}"
# puts "XXX: torrents: #{Torrent.new.get_torrent(1)}"
puts "XXX: torrents: #{Torrent.new.add_torrent("magnet:?xt=urn:btih:3e16157f0879eb43e9e51f45d485feff90a77283&dn=Ubuntu+10.04+LTS+x32&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A80&tr=udp%3A%2F%2Ftracker.publicbt.com%3A80&tr=udp%3A%2F%2Ftracker.istole.it%3A6969&tr=udp%3A%2F%2Ftracker.ccc.de%3A80")}"