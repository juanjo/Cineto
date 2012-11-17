class TorrentsController < ApplicationController
  def index
    @torrents = TorrentApi.client.all
  end

  def show
    @torrent = TorrentApi.client.find(params[:id].to_i)
  end

  def new
  end

  def create
    torrent = TorrentApi.client.create(params[:torrent_uri])
    redirect_to torrent_path(torrent.id), :notice => "Successfully created torrent."
  end

  def destroy
    @torrent = TorrentApi.client.destroy(params[:id].to_i)
    redirect_to torrents_url, :notice => "Successfully destroyed torrent."
  end
end
