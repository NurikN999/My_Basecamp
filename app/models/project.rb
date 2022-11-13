class Project < ActiveRecord::Base

    def create(project_info)
        begin
            db = get_db()
            @id = db.query("SELECT COUNT(*) FROM projects").next[0] + 1
            @project = db.query("INSERT INTO projects() VALUES (?,?)"),[@id, project_info['name'], project_info['description']]
            p @project.first
            db.close
            return @project
        rescue => exception
            p exception
        end
    end

    def find_creator(creator_id)
        begin
            db = get_db()
            creator_name = db.query("SELECT firstname FROM users JOIN projects ON users.id = projects.creator WHERE projects.creator = #{creator_id}").next["firstname"].to_s
        rescue => exception
            return exception
        end
    end

    def all_projects()
        @project_list = []
        begin
            db = get_db()
            @projects = db.query("SELECT * FROM projects")
            @projects.each do |row|
                @project_list.push(row)
            end
        rescue => exception
            p exception
        end
        return @project_list
    end

    def add_member(project_members)
        begin
            db = get_db
            id = db.query("SELECT COUNT(*) FROM project_members").next[0] + 1
            result = db.query("INSERT INTO project_members(id, project_id, member_id, role) VALUES (?,?,?,?)"),[id, project_members['project_id'], project_members['member_id'], project_members['role']]
            p result.to_s
            return result
        rescue => exception
            p exception
        end
    end

    def update(project_id, attribute, value)
        begin
            db = get_db
            result = db.query("UPDATE projects SET #{attribute} = '#{value}' WHERE id = #{project_id}").next
            return result
        rescue => exception
            p 'Exception occured'
            p exception
        end
    end

    def destroy(project_id)
        begin
            db = get_db
            result = db.query("DELETE FROM projects WHERE id = #{project_id}").next
            return result
        rescue => exception
            p 'Exception occured'
            p exception
        end
    end

    def get_db
        db = SQLite3::Database.new './db/development.sqlite'
        db.results_as_hash = true
        db
    end
end