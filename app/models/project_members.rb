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

    def delete_by_id()
        db = get_db
        db.query("DELETE FROM project_members where id = 9")
    end

    def get_db
        db = SQLite3::Database.new './db/development.sqlite'
        db.results_as_hash = true
        db
    end
end