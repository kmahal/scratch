require 'oauth/controllers/provider_controller'
class OauthController < ApplicationController
  include OAuth::Controllers::ProviderController

  protected
  # Override this to match your authorization page form
  # It currently expects a checkbox called authorize
  # def user_authorizes_token?
  #   params[:authorize] == '1'
  # end

  # should authenticate and return a user if valid password.
  # This example should work with most Authlogic or Devise. Uncomment it
  # def authenticate_user(username,password)
  #   user = User.find_by_email params[:username]
  #   if user && user.valid_password?(params[:password])
  #     user
  #   else
  #     nil
  #   end
  # end
  def authorize
    @token = ::RequestToken.find_by_token params[:oauth_token]
    unless @token.invalidated?
      if request.post?
        if params[:authorize] == '1'
          @token.authorize!(current_user)
          if @token.oauth10?
            @redirect_url = params[:oauth_callback] || @token.client_application.callback_url
          else
            @redirect_url = @token.oob? ? @token.client_application.callback_url : @token.callback_url
          end

          if @redirect_url
            if @token.oauth10?
              redirect_to "#{@redirect_url}?oauth_token=#{@token.token}"
            else
              redirect_to "#{@redirect_url}?oauth_token=#{@token.token}&oauth_verifier=#{@token.verifier}"
            end
          else
            render :action => "authorize_success"
          end
        elsif params[:authorize] == "0"
          @token.invalidate!
          render :action => "authorize_failure"
        end
      end
    else
      render :action => "authorize_failure"
    end
  end

end
