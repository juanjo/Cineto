require 'test_helper'

class TorrentTest < ActiveSupport::TestCase
  def test_should_be_valid
    torrent = FactoryGirl.create(:torrent)
    assert torrent.valid?
  end
end