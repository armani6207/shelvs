class LibraryController < ApplicationController

    get '/libraries/new' do
        @session = session
        erb :'/library/new'
    end

    post '/libraries' do
        
    end

end