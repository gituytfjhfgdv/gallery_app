require 'net/https'
require 'uri'

class OAuthesController < ApplicationController
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
end
