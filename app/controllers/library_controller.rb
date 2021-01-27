class LibraryController < ApplicationController

    get '/libraries/new' do
        @session = session
        @books = Book.all
        erb :'/library/new'
    end

    post '/libraries' do
        library = Library.create(params[:library])
        library.update(user_id: session[:user_id])
        if !params[:book].empty?
            library.books << Book.create(params[:book])
        end
        redirect '/'
    end



end