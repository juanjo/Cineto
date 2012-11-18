require 'test_helper'

class TransmissionApiWrapperTest < ActiveSupport::TestCase
  def test_client

    TransmissionApi.expects(:new).with(
      :username => "username",
      :password => "username",
      :url      => "http://api.url",
      :fields   => TransmissionApiWrapper::TORRENT_FIELDS
    ).returns("client")

    assert_equal("client", TransmissionApiWrapper.client)
  end
end