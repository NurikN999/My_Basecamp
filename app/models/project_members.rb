class ProjectMembers < ActiveRecord::Base

    def all_members_of_project(project_id)
        @member_list = []
        begin
            db = get_db()
            @members = db.query("SELECT * FROM project_members WHERE project_id IN (#{project_id})")
            @members.each do |row|
                @member_list.push(row)
            end
        rescue => exception
            p exception
        end
        return @member_list
    end

    def get_db
        db = SQLite3::Database.new './db/development.sqlite'
        db.results_as_hash = true
        db
    end
end