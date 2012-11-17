require "test_helper"

class TorrentsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template "index"
  end

  def test_show
    torrent = FactoryGirl.create(:torrent)
    get :show, :id => torrent
    assert_template "show"
  end

  def test_new
    get :new
    assert_template "new"
  end

  def test_create_invalid
    Torrent.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template "new"
    assert_not_nil flash[:alert]
  end

  def test_create_valid
    post(
      :create,
      :torrent => {
        :uri => "http://torrent.com/uri.torrent"
      }
    )

    assert_redirected_to torrent_path(assigns(:torrent))
    assert_not_nil flash[:notice]
  end

  def test_edit
    get :edit, :id => Torrent.first
    assert_template "edit"
  end

  def test_update_invalid
    Torrent.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Torrent.first
    assert_template "edit"
  end

  def test_update_valid
    Torrent.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Torrent.first
    assert_redirected_to torrent_path(assigns(:torrent))
  end

  def test_destroy
    torrent = Torrent.first
    delete :destroy, :id => torrent
    assert_redirected_to torrents_path
    assert !Torrent.exists?(torrent.id)
  end
end
