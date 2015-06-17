class DbCredentialsGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  def create_database_credentials
    unless File.exists?('config/database_credentials.yml')
      #file doesnt exist... create it
      create_file "config/database_credentials.yml", <<-FILE
#Manage DB credentials
#The section below is appropriate for the #{file_name} database. 
#Any additions made by hand to this file should be in the following format:
#environment:
# db_name:
#   home_path: <path to home dir>
#   username: <path to username file>/environment_dbname_username.txt
#   password: <path to password file>/environment_dbname_password.txt
# other_db_name:
#   home_path: ...
#   username: ...
#   password: ...
#
#{Rails.env}:
  #{file_name}:
    home_path: "#{Dir.home}"
    username: "/config/passwords/#{Rails.env}_#{file_name}_username.txt"
    password: "/config/passwords/#{Rails.env}_#{file_name}_password.txt"

      FILE
    else
      unless File.open('config/database_credentials.yml').read().include? "#{file_name}:"
        inject_into_file 'config/database_credentials.yml',"
  #{file_name}:
    home_path: \"#{Dir.home}\"
    username: \"/config/passwords/#{Rails.env}_#{file_name}_username.txt\"
    password: \"/config/passwords/#{Rails.env}_#{file_name}_password.txt\"

", after: /#{Rails.env}:/, verbose: true, force: false
      end
    end

  end

  def load_credentials
    unless File.exists?('config/initializers/database_credentials.rb')
      copy_file("database_credentials.rb",'config/initializers/database_credentials.rb')
    end
  end

end
