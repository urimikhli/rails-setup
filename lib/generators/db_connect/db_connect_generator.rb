class DbConnectGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)


  def add_to_database_to_yml
    #insert #EOF so inject will work.
    unless File.open('config/database.yml').read().include? "#EOF"
      File.open('config/database.yml', 'a') do |f1|
        f1 << "\n#EOF"
      end
    end
    #if entry doesnt exist inject it. Force:false means that it doesnt repeat
    unless File.open('config/database.yml').read().include? "#{file_name}:"
      say("Please enter some details about the (#{file_name}) database in the development environment:")

      adapter = ask("adapter?[mysql2]:")
      adapter = "mysql2" if adapter.blank?

      host = ask("host?[localhost]:")
      host = "localhost" if host.blank?

      port = ask("port?[3307]:")
      port = 3307 if port.blank?

      sslca = ask("path to database ssl certificate if any[]")
      unless sslca.blank?
        sslca = "sslca: #{sslca}"
      end

      inject_into_file 'config/database.yml',"
#{file_name}_default: &#{file_name}_default
  adapter: #{adapter}
  encoding: utf8
  reconnect: false
  pool: 5
  #{sslca}

#{Rails.env}_#{file_name}:
  <<: *#{file_name}_default
  host: #{host}
  port: #{port}
  database: #{file_name}

"   , before: /^\#EOF/, verbose: true, force: false
    end

  end

  def create_abstract_db_model
      create_file "app/models/#{file_name}_db.rb", <<-FILE
class #{class_name}Db < ActiveRecord::Base
  self.abstract_class = true

  config = ActiveRecord::Base.configurations["\#{Rails.env}_#{file_name}"]

  establish_connection( config )

end
    FILE
  end

  
end
