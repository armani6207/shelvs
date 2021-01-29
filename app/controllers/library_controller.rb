require_relative './application_controller.rb'
require 'pry'
class LibraryController < ApplicationController

    get '/libraries' do
        @libraries = Library.all
        erb :'/library/index'
    end

    get '/libraries/new' do
        @session = session
        @books = Book.all
        erb :'/library/new'
    end

    post '/libraries' do
        puts params
        user = User.find(session[:user_id])
        if !user.libraries.exists?(name: params[:library][:name])
            library = Library.create(params[:library])
            library.update(user_id: session[:user_id])
            if !params[:book][:title] != ""
                library.books << Book.create(params[:book])
            end
            redirect "/libraries/#{library.id}"
        else
            redirect '/libraries/new'
        end
    end

    get '/libraries/:id' do
        if Library.exists?(params[:id])
            @library = Library.find(params[:id])
            erb :'/library/show'
        else
            redirect '/error'
        end
    end

    get '/libraries/:id/edit' do
        @books = Book.all
        @session = session

        if Library.exists?(params[:id])
            @library = Library.find(params[:id])
            erb :'/library/edit'
        else
            redirect '/error'
        end
    end

    patch '/libraries/:id' do
        user = User.find(session[:user_id])
        library = Library.find(params[:id])
        if (library.name != params[:library][:name] ? !user.libraries.exists?(name: params[:library][:name]) : true)
            library.update(params[:library])
            if params[:book][:title] != ""
                library.books << Book.create(params[:book])
            end
            redirect "/libraries/#{library.id}"
        else
            redirect '/error'
        end
    end

    delete '/libraries/:id' do
        Library.delete(params[:id])
        redirect '/books'
    end

end