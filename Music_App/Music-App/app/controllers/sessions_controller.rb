class SessionsController < ApplicationController
    before_action :ensure_logged_in

    def new
        render :new
    end

    def create
        user = User.find_by_credentials(params[:user][:email], params[:user][:password])
        if user
            login_user!(user)
            redirect_to cats_url
        else
            flash.now[:errors] = ["wrong password/username"]
            render :new
        end
    end

    def destroy
        current_user.reset_session_token!
        session[:session_token] = nil
        redirect_to new_session_url
    end

end