require 'test_helper'

class TorrentsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Torrent.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Torrent.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Torrent.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to torrent_url(assigns(:torrent))
  end

  def test_edit
    get :edit, :id => Torrent.first
    assert_template 'edit'
  end

  def test_update_invalid
    Torrent.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Torrent.first
    assert_template 'edit'
  end

  def test_update_valid
    Torrent.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Torrent.first
    assert_redirected_to torrent_url(assigns(:torrent))
  end

  def test_destroy
    torrent = Torrent.first
    delete :destroy, :id => torrent
    assert_redirected_to torrents_url
    assert !Torrent.exists?(torrent.id)
  end
end
