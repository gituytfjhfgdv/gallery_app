class PhotosController < ApplicationController
  include UserAuthentication
  def index
    @photos = current_user.photos.order(created_at: :desc)
  end
end
