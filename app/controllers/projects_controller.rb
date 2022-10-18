class ProjectController < ApplicationController
    #GET: /projects
    get "/projects" do
        if signed_in?
            @projects = Project.all_projects()
            
        else
            return {
                'name' => 'Nurmukhamed'
            }.to_json
            # redirect '/sign_in'
        end
    end
end