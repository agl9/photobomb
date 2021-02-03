class StaticPagesController < ApplicationController
  def search
    if params[:user_id]
      begin
        @flickr=Flickr.new
        @params = {user_id: params[:user_id], page: params[:page], per_page: 10}
        @photos = @flickr.photos.search(@params)
        if @photos.none?
          flash.now[:notice] = "No Photos found"
        end
      rescue Flickr::FailedResponse => e
        flash.now[:notice] = "user not found"
      end

    elsif params[:tags]
      begin
        @flickr=Flickr.new
        @params = {tags: params[:tags], page: params[:page], per_page: 10}
        @photos = @flickr.photos.search(@params)
        if @photos.none?
          flash.now[:notice] = "No Photos found"
        end
      rescue Flickr::FailedResponse => e
        flash.now[:notice] = "Tag not found"
      end
    else
      @flickr = Flickr.new
      @photos = @flickr.photos.getRecent
    end
  end
end
