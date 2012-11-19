class TorrentsController < ApplicationController
  def index
    api_response = TransmissionApiWrapper.client.all
    @torrents = Torrent.parse_all( api_response )
  end

  def create
    if true #( params[:uri] =~ /^http:\/\/www.clearbits.net/ )
      TransmissionApiWrapper.client.create( params[:uri] )
      redirect_to torrents_path, :notice => "Successfully created torrent."
    else
      redirect_to torrents_path, :alert => "Only http://www.clearbits.net torrents allowed."
    end
  end

  def destroy
    TransmissionApiWrapper.client.destroy(params[:id].to_i)
    redirect_to torrents_url, :notice => "Successfully destroyed torrent."
  end

  def download
    filename = params[:filename]
    path = "#{downloads_path}/#{filename}"
    send_file path
  end

  private

  def downloads_path
    APP_CONFIG[:downloads_path]
  end
end
