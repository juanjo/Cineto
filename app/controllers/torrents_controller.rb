class TorrentsController < ApplicationController
  def index
    @torrents = TorrentApi.client.all.reverse
  end

  def show
    @torrent = TorrentApi.client.find(params[:id].to_i)
  end

  def new
  end

  def create
    torrent = TorrentApi.client.create(params[:torrent_uri])
    redirect_to torrents_path, :notice => "Successfully created torrent."
  end

  def destroy
    @torrent = TorrentApi.client.destroy(params[:id].to_i)
    redirect_to torrents_url, :notice => "Successfully destroyed torrent."
  end

  def download
    filename = params[:filename]
    path = "#{APP_CONFIG[:downloads_path]}/#{filename}"
    puts "XXX: path: #{path}"
    send_file path
  end
end
