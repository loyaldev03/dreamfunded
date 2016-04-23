  require 'net/http'
    require 'net/https'
    require 'uri'
    require 'rexml/document'

    class ImportController < ApplicationController

      def authenticate
        client_id = "53258587093-kl5m6bi61j835409ncebrhr9dtvmt0se.apps.googleusercontent.com"
        client_secret = "zuN6_MdtvUkOlqKfyL9sL6tF"
        client = OAuth2::Client.new(client_id, client_secret,
                   site: 'https://accounts.google.com',
                   token_url: '/o/oauth2/token',
                   authorize_url: '/o/oauth2/auth')
        url = client.auth_code.authorize_url(scope: "https://www.google.com/m8/feeds",
                   redirect_uri: 'https://dreamfunded.com/authorise')
        redirect_to url
      end

      def authorise
        client_id = "53258587093-kl5m6bi61j835409ncebrhr9dtvmt0se.apps.googleusercontent.com"
        client_secret = "zuN6_MdtvUkOlqKfyL9sL6tF"
        client = OAuth2::Client.new(client_id, client_secret,
                   site: 'https://accounts.google.com',
                   token_url: '/o/oauth2/token',
                   authorize_url: '/o/oauth2/auth')
        #token = client.auth_code.get_token(params[:code], :redirect_uri => 'http://localhost:3000/authorise')
        token = client.auth_code.get_token(params[:code], :redirect_uri => 'https://dreamfunded.com/authorise')
        user = GoogleContactsApi::User.new(token)
        @contacts = user.contacts
        @hash = {}
        @contacts.each do |contact|
          if contact.full_name
            @hash[contact.full_name] = contact.primary_email
          end
        end
        @hash = @hash.sort.to_h
      end

    end
