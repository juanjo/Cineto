class TorrentsController < ApplicationController
  def index
    @torrents = Torrent.all
  end

  def show
    @torrent = Torrent.find(params[:id])
  end

  def new
    @torrent = Torrent.new
  end

  def create
    @torrent = Torrent.new(params[:torrent])
    if @torrent.save
      redirect_to @torrent, :notice => "Successfully created torrent."
    else
      render :action => 'new'
    end
  end

  def edit
    @torrent = Torrent.find(params[:id])
  end

  def update
    @torrent = Torrent.find(params[:id])
    if @torrent.update_attributes(params[:torrent])
      redirect_to @torrent, :notice  => "Successfully updated torrent."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @torrent = Torrent.find(params[:id])
    @torrent.destroy
    redirect_to torrents_url, :notice => "Successfully destroyed torrent."
  end
end
