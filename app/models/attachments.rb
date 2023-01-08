class Attachments < ActiveRecord::Base
  def get_db
    db = SQLite3::Database.new './db/development.sqlite'
    db.results_as_hash = true
    db
  end
end
