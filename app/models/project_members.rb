class ProjectMembers < ActiveRecord::Base
    def create(project_members)
        begin
            db = get_db
            id = db.query("SELECT COUNT(*) FROM project_members").next[0] + 1
            result = db.query("INSERT INTO project_members(id, project_id, member_id, role) VALUES(?,?,?,?)"),[id, project_members['project_id'], project_members['member_id'], project_members['role']]
            p result.to_s
        rescue => exception
            p exception
        end
    end

    def get_db
        db = SQLite3::Database.new './db/development.sqlite'
        db.results_as_hash = true
        db
    end
end