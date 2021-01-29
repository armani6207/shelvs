require 'sinatra/base'

class Helpers

    def self.current_user(session)
        @user = User.find(session[:user_id])
    end

    def self.is_logged_in?(session)
        !!session[:user_id]
    end

    def self.redirect_if_logged_out(session, user)
        if Helpers.current_user(session) != library.user then redirect '/error' end
    end

end