class LibraryController < ApplicationController

    get '/libraries/new' do
        erb :'/library/new'
    end

    post '/libraries' do
        
    end

end