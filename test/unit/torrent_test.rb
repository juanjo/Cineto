require 'test_helper'

class TorrentTest < ActiveSupport::TestCase
  def test_parse
    torrent = Torrent.parse( JSON.parse( read_fixture( "api_responses/find.json" ) ) )

    assert_equal( "2012-11-17 18:11", torrent.added_at.strftime( "%Y-%m-%d %H:%m" ) )
    assert_equal( 2, torrent.torrent_id )
    assert_equal( true, torrent.is_finished? )
    assert_equal( "w4yr - e", torrent.name )
    assert_equal( 0.21, torrent.percent_done )
    assert_equal( 100, torrent.rate_download )
    assert_equal( 200, torrent.rate_upload )
    assert_equal( 42557063, torrent.size )
    assert_equal( 2, torrent.files.length )

    file = torrent.files.first
    assert_equal( 10, file.bytes_completed )
    assert_equal( 6725133, file.size )
    assert_equal( "w4yr - e/w4yr - 06 - Home.mp3", file.name )
  end

  def test_parse_all
    torrents = Torrent.parse_all( JSON.parse( read_fixture( "api_responses/all.json" ) ) )

    assert_equal( 2, torrents.length )
  end

  def test_is_video
    assert_equal( true, Torrent.is_video?( "hola.avi" ) )
    assert_equal( true, Torrent.is_video?( "hola.mp4" ) )
    assert_equal( true, Torrent.is_video?( "hola.mkv" ) )
    assert_equal( true, Torrent.is_video?( "hola.mov" ) )
    assert_equal( false, Torrent.is_video?( "hola.wadus" ) )
  end
end