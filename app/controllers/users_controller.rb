class UsersController < ApplicationController


    get "/users/:slug" do 
       @user =  User.find_by_slug(params[:slug])
        erb :"users/show"
    end


    get '/signup' do 
        if !logged_in?
            erb :'users/signup'
        else
            redirect  "/tweets"
        end
    end
    
    post '/signup' do 
        user = User.new(username: params[:username], email: params[:email], password: params[:password])
        
        if !logged_in? && !params.values.include?("") 
            user.save
            redirect "/tweets"
        else
            redirect "/signup"
        end
    end

    get '/login' do 
        
        if !logged_in? 
            erb :'users/login'
        else
            redirect "/tweets"
        end
    end

    post '/login' do
        user = User.find_by(username: params[:username])
       
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/tweets"
        else
            redirect "/login"
        end
    end

    
    get '/logout' do 
        if !logged_in?
            redirect "/index"
        else
            session.clear 
            redirect "/login"
        end
    end


end
