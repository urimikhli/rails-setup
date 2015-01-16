#
Rails.application.config.after_initialize do
  ActiveSupport.on_load(:active_record) do
    database_credentials = YAML::load(File.open('config/database_credentials.yml'))
    database_credentials[Rails.env].each do |db, credentials|
      
      #read credentials file for the location of the password files and then insert their contents
      #into credentials hash 
      if ActiveRecord::Base.configurations["#{Rails.env}_#{db}"].present?
        user_path = credentials["home_path"] + credentials["username"]
        pswd_path = credentials["home_path"] + credentials["password"]

        credentials["username"] = File.read(user_path).strip if File.exists?(user_path)
        credentials["password"] = File.read(pswd_path).strip if File.exists?(pswd_path)

        #Finally, add credentials to ActiveRecord
        #if password file doesnt exist, keep the path to it as the password. This will aid debugging
        ActiveRecord::Base.configurations["#{Rails.env}_#{db}"].merge!(credentials)
      end
    end
  end
end
