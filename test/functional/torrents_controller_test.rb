require "test_helper"

class TorrentsControllerTest < ActionController::TestCase
  def test_index
    client_mock = mock()
    client_mock.expects(:all).returns( JSON.parse( read_fixture( "api_responses/all.json" ) ) )
    TransmissionApiWrapper.expects(:client).returns(client_mock)

    get :index
    assert_template "index"
    assert_equal( 2, assigns(:torrents).length )
  end

  def test_create
    client_mock = mock()
    client_mock.expects(:create).with("torrent_url")
    TransmissionApiWrapper.expects(:client).returns(client_mock)

    post(
      :create,
      :uri => "torrent_url"
    )

    assert_redirected_to torrents_path
    assert_not_nil flash[:notice]
  end

  def test_destroy
    client_mock = mock()
    client_mock.expects(:destroy).with(1)
    TransmissionApiWrapper.expects(:client).returns(client_mock)

    delete :destroy, :id => "1"
    assert_redirected_to torrents_path
  end

  def test_download
    @controller.expects(:downloads_path).returns("#{Rails.root}/test/fixtures")
    get :download, :filename => "downloads/file.txt"
    assert_equal( "wadus", response.body )
  end
end
