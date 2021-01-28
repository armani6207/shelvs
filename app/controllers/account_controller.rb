require_relative './application_controller.rb'
class AccountController < ApplicationController

    get '/user/:id' do
        @session = session
        @user = User.find(params[:id])
        @libraries = @user.libraries
        erb :'/user/show'
    end

    get '/account' do
        if Helpers.is_logged_in?(session)
            redirect "/user/#{session[:user_id]}"
        else
            redirect '/error'
        end
    end

    get '/user/:id/edit' do
        @user = User.find(params[:id])
        if Helpers.current_user(session) == @user
            erb :'/user/edit'
        else
            redirect '/error'
        end
    end

    patch '/user/:id' do
        user = User.find(params[:id])
        if (user.email != params["email"] ? !User.exists?(email: params["email"]) : true)
            user.update(name: params["name"], email: params["email"])
        
            if params["current_password"] != ""
                if user.authenticate(params["current_password"])
                    user.password=(params["new_password"])
                    user.save ? (redirect '/account') : (redirect '/error')
                else
                    redirect '/error'
                end
            else
                redirect '/account'
            end
        else
            redirect "/user/#{user.id}/edit"
        end
    end

    delete '/user/:id' do
        User.delete(params[:id])
        redirect '/logout'
    end

end