require_relative './application_controller.rb'
class BookController < ApplicationController

    get '/books' do
        @books = Book.all
        erb :'/book/index'
    end

    get '/books/new' do
        @session = session
        if Helpers.is_logged_in?(session)
            @libraries = User.find(session[:user_id]).libraries
        end
        erb :'/book/new'
    end

    post '/books' do
        book = Book.create(params[:book])
        if params[:library][:name] != ""
            book.libraries << Library.create(name: params[:library][:name], user_id: session[:user_id])
        end
        redirect "/books/#{book.id}"
    end

    get '/books/:id' do
        if Book.exists?(params[:id])
            @book = Book.find(params[:id])
            erb :'/book/show'
        else
            redirect '/error'
        end
    end

    get '/books/:id/edit' do
        @session = session

        if Book.exists?(params[:id])
            @book = Book.find(params[:id])
            if Helpers.is_logged_in?(session)
                @libraries = User.find(session[:user_id]).libraries
            end
            erb :'/book/edit'
        else
            redirect '/error'
        end
    end

    patch '/books/:id' do
        book = Book.find(params[:id])
        book.update(params[:book])
        if params[:library][:name] != ""
            book.libraries << Library.create(name: params[:library][:name], user_id: session[:user_id])
        end
        redirect "/books/#{book.id}"
    end

    delete '/books/:id' do
        Book.delete(params[:id])
        redirect '/books'
    end
end