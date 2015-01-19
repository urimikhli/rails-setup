if ENV['RAILS_ENV'] == "development" || ENV['RAILS_ENV'].class == NilClass
  require 'rails/commands/server'
  require 'rack'
  require 'webrick'
  require 'webrick/https'
  if ENV['SSL'] == "true"
    module Rails
      class Server < ::Rack::Server
        def default_options
          super.merge({
            :Port => 3001,
            :environment => (ENV['RAILS_ENV'] || "development").dup,
            :daemonize => false,
            :debugger => false,
            :pid => File.expand_path("tmp/pids/server.pid"),
            :config => File.expand_path("config.ru"),
            :SSLEnable => true,
            :SSLVerifyClient => OpenSSL::SSL::VERIFY_NONE,
            :SSLPrivateKey => OpenSSL::PKey::RSA.new(
              File.open("certs/server.key").read),
            :SSLCertificate => OpenSSL::X509::Certificate.new(
              File.open("certs/server.crt").read),
            :SSLCertName => [["CN", "localhost.ssl"]],
          })
        end
      end
    end
  end
end
