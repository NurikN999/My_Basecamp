class User < ActiveRecord::Base
    def create(user_info)
        begin
            db = get_db()
            @id = db.query("SELECT count(*) FROM users").next[0] + 1
            @user = db.query 'INSERT INTO users(id, firstname, lastname, age, password, email) VALUES (?,?,?,?,?,?)',[@id, user_info['firstname'], user_info['lastname'], user_info['age'], user_info['password'], user_info['email']]
            p @user.first
            db.close
            return @user 
        rescue => exception
            p exception
        end
    end

    def all_users()
        @user_list = []
        begin
            db = get_db()
            @users = db.query('SELECT * FROM users')
            @users.each do |row|
                @user_list.push(row)
            end
        rescue => exception
            p exception
        end
        return @user_list
    end

    def find(user_id)
        db = get_db()
        @user = db.query "SELECT * FROM users WHERE id = #{user_id}"
        # db.close
        return @user.next
    end

    def update(user_id, attribute, value)
        db = get_db()
        @result = db.query("UPDATE users SET #{attribute} = '#{value}' WHERE id = #{user_id}").next
        return @result
    end

    def destroy(user_id)
        db = get_db()
        @result = db.query("DELETE FROM users WHERE id = #{user_id}")
        return @result
    end

    def get_db
        db = SQLite3::Database.new './db/development.sqlite'
        db.results_as_hash = true
        db
    end
end
