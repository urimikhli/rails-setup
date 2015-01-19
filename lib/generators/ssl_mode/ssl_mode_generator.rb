class SslModeGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def ssl_config
    # set application.rb config.
    environment 'config.force_ssl = true if ENV[\'SSL\'] == true'
  end

  def create_local_certs
    say("You need to have a certs/ directory where your self signed certificates will be stored.  It will be populated with the correct files, but these files will be empty. You will still need to create them:")
    create_certs_dir = ask("Would you like to create certs/ directory?[y/N]:")
    if create_certs_dir =~ /[Yy]/
      unless File.exists?('certs/server.key')
        run "cp -rf #{Gem.loaded_specs['rails_setup'].full_gem_path}/lib/generators/ssl_mode/templates/certs certs"
      end
    end
  end

  def set_ssl_rails
    #add the contents of sslrails.rb file into bin/rails 

    sentinal = /require\s\'rails\/commands\'/i

    data = File.read(Gem.loaded_specs['rails_setup'].full_gem_path + "/lib/generators/rails_setup/templates/sslrails.rb")

    inject_into_file 'bin/rails', "\n#{data}\n",before: sentinal, verbose: true, force: false
  end

end
