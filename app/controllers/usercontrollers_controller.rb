class UsercontrollersController < ApplicationController
  # GET: /usercontrollers
  get "/users" do
    if signed_in?
      @user = User.find(session[:user_id])
      erb :"/usercontrollers/index.html"
    else
      redirect '/sign_in'
    end
  end

  # GET: /sign_in
  get "/sign_in" do
    if signed_in?
      redirect '/users'
    else
      erb :"/usercontrollers/sign_in.html"
    end
  end

  #POST: /sign_in
  post "/sign_in" do
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect '/users'
    else
      redirect '/sign_in'
    end
  end

  #GET: /register
  get "/register" do
    if !signed_in?
      erb :"/usercontrollers/register.html"
    else
      redirect "/sign_in" 
    end
  end

  #POST: /register
  post "/register" do
    if !signed_in?
      firstname = params[:firstname]
      lastname = params[:lastname]
      age = params[:age]
      password = params[:password]
      email = params[:email]
      user_info = {
        'firstname' => firstname,
        'lastname' => lastname,
        'age' => age,
        'password' => password,
        'email' => email
      }
      User.create(user_info)
    else
      redirect "/users"
    end
  end

  # POST: /usercontrollers
  post "/users" do
    if signed_in?
      firstname = params[:firstname]
      lastname = params[:lastname]
      age = params[:age]
      password = params[:password]
      email = params[:email]
      user_info = {
        'firstname' => firstname,
        'lastname' => lastname,
        'age' => age,
        'password' => password,
        'email' => email
      }
      User.create(user_info)
      redirect '/users'
    else
      redirect '/sign_in'
    end
  end

  #GET: /sign_out
  get "/sign_out" do
    session.destroy
    redirect '/sign_in'
  end

  #PATCH: /users/:id
  post "/users/edit/:id" do
    if signed_in?
      if params[:new_password].empty?
        redirect '/users'
      else
        @user = User.find(params[:id])
        if @user
          if @user.update(params[:id], 'password', params[:new_password])
            redirect to "/users/edit/#{@user.id}"
          else
            redirect to "/users/#{@user.id}/edit"
          end
        else
          redirect to '/users'
        end
      end
    else
      redirect '/sign_in'
    end
  end

  # GET: /users/:id/edit
  get "/users/:id/edit" do
    if signed_in?
      @user = User.find(params[:id])
      erb :"/usercontrollers/edit.html"
    else
      redirect "/sign_in"
    end
  end

  get "/users/:id" do
    erb :"/usercontrollers/index.html"
  end

  get "/users/:id/delete" do
    if signed_in?
      @user = User.find(params[:id])
      erb :"/usercontrollers/delete.html"
    else
      redirect "/sign_in"
    end
  end

  post "/users/delete/:id" do
    if signed_in?
      @user = User.find(params[:id])
      p @users
      if @user
        
        if @user.destroy(params[:id])
          session.destroy
          redirect '/sign_in'
        else
          redirect "/users/delete/#{params[:id]}"
        end

      else
        redirect '/users'
      end
    else
      redirect '/sign_in'
    end
  end

  get "/users/delete/:id" do
    erb :"/usercontrollers/index.html"
  end

  # GET: /usercontrollers/5
  get "/usercontrollers/:id" do
    erb :"/usercontrollers/show.html"
  end

  # GET: /usercontrollers/5/edit
  get "/usercontrollers/:id/edit" do
    erb :"/usercontrollers/edit.html"
  end

  # PATCH: /usercontrollers/5
  patch "/usercontrollers/:id" do
    redirect "/usercontrollers/:id"
  end

  # DELETE: /usercontrollers/5/delete
  delete "/usercontrollers/:id/delete" do
    redirect "/usercontrollers"
  end
end
