include FileUtils::Verbose
class ProjectController < ApplicationController
    #GET: /projects
    # working on the main project page
    get "/projects" do
        @projects = Project.all()
        @user = User.find_by(id: session[:user_id])
        erb :"projectcontrollers/main.html"
    end


    #POST: /project/:id/attachment
    post "/project/:id/attachment" do
        file = params[:upload]
        filename = file["filename"]
        project_id = params[:id]
        file_ext = File.extname(filename).strip.downcase[1..-1]
        accepted_ext = ['png', 'jpg', 'pdf', 'txt']
        if  accepted_ext.include? file_ext
            dir_path = "public/uploads/"
            tempfile = params[:upload][:tempfile]
            cp(tempfile.path, "public/uploads/#{filename}")
            attachment_info = {
                "title" => filename,
                "path" => dir_path + filename,
                "project_id" => project_id
            }
            Attachments.create(attachment_info)
            return filename
        else
            return {
                "error_code" => 101,
                "message" => "wrong file extension"
            }.to_s
        end
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

    #PATCH: /project/:id/edit/name
    post "/project/:id/edit/name" do
        if signed_in?
            if params[:id].empty?
                return 'Error'
            else
                @project = Project.find(params[:id])
                if @project
                    @project.update(params[:id], 'name', params[:name])
                    redirect "/projects"
                else
                    redirect "/projects"
                end
            end
        else
            redirect "/projects"
        end
    end

    #PATCH: /project/:id/edit/description
    post "/project/:id/edit/description" do
        if signed_in?
            if params[:id].empty?
                return 'Error'
            else
                @project = Project.find(params[:id])
                if @project
                    @project.update(params[:id], 'description', params[:description])
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
            project.update(params[:id], 'name', params[:description])
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
        project_id = Project.create(project_info)['id']
        project_members = {
            "project_id" => project_id,
            "member_id" => session[:user_id],
            "role" => 1
        }
        ProjectMembers.create(project_members)
        # p project_members.to_s

        redirect "/projects"
    end

    #POST: /project/:id/edit/invite
    post "/project/:id/edit/invite" do
        user_id = User.find_by(email: params[:email])['id']
        if user_id
            project_member = {
                "project_id" => params[:id],
                "member_id" => user_id,
                "role" => 0
            }
            ProjectMembers.create(project_member)
            redirect "/projects"
        else
            redirect "/projects"
        end
    end

    #DELETE: /project/delete
    post "/project/:id/delete" do
        if signed_in?
            # project = Project.find_by(id: params[:id])
            Project.destroy_by(id: params[:id])
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
