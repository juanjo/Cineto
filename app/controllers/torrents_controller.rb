class TorrentsController < ApplicationController
  def index
    api_response = TransmissionApiWrapper.client.all
    @torrents = Torrent.parse_all( api_response )
  end

  def create
    TransmissionApiWrapper.client.create(params[:torrent_uri])
    redirect_to torrents_path, :notice => "Successfully created torrent."
  end

  def destroy
    TransmissionApiWrapper.client.destroy(params[:id].to_i)
    redirect_to torrents_url, :notice => "Successfully destroyed torrent."
  end

  def download
    filename = params[:filename]
    path = "#{APP_CONFIG[:downloads_path]}/#{filename}"
    send_file path
  end
end
