class TweetsController < ApplicationController

    get "/tweets" do 
        if !logged_in?
            redirect "/login"
        else 
            @user = User.find_by(id: session[:user_id])
            erb :'tweets/index'
        end
    end


    get "/tweets/new" do 
        if logged_in?
            erb  :"tweets/new"
        else
            redirect "/login"
        end
    end

    get "/tweets/:id" do 
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            erb :'tweets/show'
        else
            redirect "/login"
        end
    end

    post "/tweets" do 
        if logged_in?
            if params[:content] ==  ""
                redirect "/tweets/new"
            else
                @user = User.find(session[:user_id])
                @tweet = Tweet.new(:content => params[:content])
                @user.tweets << @tweet
                @user.save 
            end
            redirect "/tweets/#{@tweet.id}"
        else
            redirect "/login"
        end
    end

    get "/tweets/:id/edit" do 
        if logged_in? 
            @tweet = Tweet.find_by(id: params[:id])
            erb :'tweets/edit'
        else
            redirect "/login"
        end
    end

    patch "/tweets/:id" do 
        @tweet = Tweet.find_by(id: params[:id])
        @user = User.find(session[:user_id])

        if logged_in?
            if params[:content] ==  ""
                redirect "/tweets/#{params[:id]}/edit"
            else
                if @tweet.user == current_user
                    @tweet.update(:content => params[:content])
                    @user.save 
                    redirect "/tweets/#{@tweet.id}"
                else
                    redirect "/tweets"
                end
            end
        else
            redirect "/login"
        end
    end

    delete '/tweets/:id' do 
        @tweet = Tweet.find_by(id: params[:id])

        if @tweet.user == current_user
            @tweet.delete
            redirect "/tweets"
        end
    end

    









end
