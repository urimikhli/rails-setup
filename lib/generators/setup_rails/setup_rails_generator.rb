class SetupRailsGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def call_generators

    say("
        All Generators[Aa]:
          * db_connect
          * db_credentials
          * ssl_mode

        db_connect[Cc]:
        db_credentials[Rr]:
        ssl_mode[Ss]:

        Hitting enter without an entry will NOT run any generators
        ")
    choice = ask("What setup would you like to run. (Default: none)[AaCcRsSs]:")

    if choice =~ /[Aa]/ || choice =~ /[Cc]/ 
      db_name = ask("db_connect -- What is the database name?:")
      unless db_name.blank?
        generate "db_connect", db_name
      end
    end

    if choice =~ /[Aa]/ || choice =~ /[Rr]/ 
      db_name = ask("db_credentials -- What is the database name?:")
      unless db_name.blank?
        generate "db_credentials", db_name
      end
    end

    if choice =~ /[Aa]/ || choice =~ /[Ss]/ 
      generate "ssl_mode"
    end

  end

end
