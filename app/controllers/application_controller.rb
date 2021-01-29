class ApplicationController < Sinatra::Base

    register Sinatra::ActiveRecordExtension
        enable :sessions
        set :session_secret, "My Session Secret"
        set :views, Proc.new { File.join(root, "../views/") }
    
    get '/' do
        redirect '/libraries'
    end

    get "/error" do
        erb :error
    end

    get '/login' do
        erb :'/user/login'
    end

    post '/login' do
        user = User.find_by(email: params["email"])

        if user && user.authenticate(params["password"])
            session[:user_id] = user.id
            redirect '/account'
        else
            redirect '/error'
        end
    end

    get '/logout' do
        session.clear
        redirect '/'
    end

    get '/signup' do
        erb :'/user/signup'
    end

    post '/signup' do
        if !User.exists?(email: params["email"])
            user = User.new(name: params["name"], email: params["email"], password: params["password"])
            if user.save
                redirect '/login'
            else
                redirect '/error'
            end
        else
            redirect '/signup'
        end
    end


end