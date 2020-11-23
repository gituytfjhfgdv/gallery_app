require 'net/https'
require 'uri'

class OAuthsController < ApplicationController
  before_action :permit_only_photo_owner, only: :tweet

  def create
    code = params[:code]

    uri = URI.parse("#{Rails.application.credentials.my_tweet_app[:host]}oauth/token")
    http = Net::HTTP.new(uri.host)

    req = Net::HTTP::Post.new(uri.request_uri)
    data = {
      'grant_type': 'authorization_code',
      'redirect_uri': 'http://localhost:3000/oauth/callback',
      'client_id': Rails.application.credentials.my_tweet_app[:client_id],
      'client_secret': Rails.application.credentials.my_tweet_app[:client_secret],
      'code': code
    }

    req.body = URI.encode_www_form(data)

    res = http.request(req)
    response_body = JSON.parse(res.body)
    session[:oauth_access_token] = response_body['access_token']
    redirect_to photos_path
  end

  def tweet
    photo = Photo.find(params[:photo_id])
    uri = URI.parse("#{Rails.application.credentials.my_tweet_app[:host]}api/tweets")
    http = Net::HTTP.new(uri.host)

    request_header = {
      'Authorization': "Bearer #{session[:oauth_access_token]}",
      'Content-Type': 'application/json'
    }
    request = Net::HTTP::Post.new(uri.request_uri, request_header)
    data = { text: photo.title, url: url_for(photo.image_file) }.to_json
    request.body = data
    http.request(request)

    redirect_to photos_path
  end

  private

  def permit_only_photo_owner
    redirect_to photos_path if Photo.where(user: current_user, id: params[:photo_id]).blank?
  end
end
