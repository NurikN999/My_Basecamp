class ProjectController < ApplicationController
    #GET: /projects
    get "/projects" do
        @projects = Project.new.all_projects()
        @user = User.find(session[:user_id])
        erb :"projectcontrollers/index.html"
    end

    #GET: /project/:id/edit
    get "/project/:id/edit" do
        if signed_in?           
            @project = Project.find(params[:id])
            erb :"/projectcontrollers/edit.html"
        else
            redirect "/projects"
        end
    end

    #PATCH: /project/:id/edit
    post "/project/:id/edit" do
        if signed_in?
            if params[:id].empty?
                return 'Error'
            else
                @project = Project.find(params[:id])
                if @project
                    @project.update(params[:id], params[:attribute], params[:value])
                    redirect "/projects"
                else
                    redirect "/projects"
                end
            end
        else
            redirect "/projects"
        end
    end

    #PATCH: /project/:id
    patch "/project/edit/:id" do
        project = Project.find(params[:id])
        if project
            project.update(params[:id], 'name', params[:name])
            return 'Project Updated'
        else
            return 'Error'
        end
    end

    #POST: /project/new
    post "/project/new" do
        project_info = {
            "name" => params[:name],
            "description" => params[:description],
            "creator" => session[:user_id]
        }
        Project.create(project_info)

        redirect "/projects"
    end

    #DELETE: /project/delete
    post "/project/:id/delete" do
        if signed_in?
            Project.new.destroy(params[:id]) 
            redirect "/projects"
        else
            redirect "/sign_in"
        end
    end

    #GET: /project/new
    get "/project/new" do
        if signed_in?
            erb :"projectcontrollers/create.html"
        else
            redirect '/sign_in'
        end
    end
end