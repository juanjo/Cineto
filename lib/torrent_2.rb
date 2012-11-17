require "rubygems"
require "rest_client"

begin
  response =
    RestClient.get(
      "http://pepe:pepe@ilefante3:9091/transmission/rpc",
      {
        "arguments" => {
           "fields" => [ "id", "name", "totalSize" ]
        },
        "method" => "torrent-get"
      }
    )

  puts "XXX: response: #{response}"

  puts "XXX: t-id: "
rescue  RestClient::Conflict => e
  puts "e.class: #{e.class}"
  puts response = e.response
  puts "XXX: x_transmission_session_id: #{response.headers[:x_transmission_session_id]}"


  response_2 =
    RestClient.get(
      "http://pepe:pepe@ilefante3:9091/transmission/rpc",
      {
        "arguments" => {
           "fields" => [ "id", "name", "totalSize" ]
        },
        "method" => "torrent-get"
      },
      {
        "X-Transmission-Session-Id" => response.headers[:x_transmission_session_id]
      }
    )
  puts "XXX: response_2: #{response_2}"
end