class ProjectController < ApplicationController
    #GET: /projects
    get "/projects" do
        @projects = Project.all()
        len = @projects.length
        i = 0
        @project_list = []
        project_hash = Hash.new
        while i < len
            project_hash['name'] = @projects[i]['name']
            project_hash['description'] = @projects[i]['description']
            @project_list.push(project_hash)
            i+=1
        end

        p @project_list.to_s
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
            "description" => params[:description]
        }
        return Project.create(project_info)
    end
end