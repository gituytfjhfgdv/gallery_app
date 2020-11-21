class PhotosController < ApplicationController
  include UserAuthentication
  def index
    @photos = current_user.photos.order(created_at: :desc)
  end

  def new
    @photo ||= Photo.new(user: current_user)
  end

  def create
    @photo = Photo.new(photo_params).tap do |photo|
      photo.user = current_user
    end

    if @photo.save
      redirect_to photos_path
    else
      render :new
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :image_file)
  end
end
