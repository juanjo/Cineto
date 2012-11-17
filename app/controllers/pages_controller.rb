class PagesController < ActionController::Base
  layout "basic"

  def show
    render "pages/#{params[:id]}"
  end
end