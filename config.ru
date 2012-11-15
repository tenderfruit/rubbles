require "Base64"

app = Class.new do
  def self.call(env)
    new.call(env)
  end

  def call(env)
    @env = env
    @http_authorization = @env["HTTP_AUTHORIZATION"]
    if @http_authorization && username_valid && password_valid
      [200, { "Content-Type" => 'text/plain'}, ['come in!']] 
    else
      [401, { "Content-Type" => 'text/plain', "WWW-Authenticate" => "Basic"}, ['no entry!']] 
    end
  end

  def extract_credentials
    Base64.decode64(@http_authorization.split[1]).split(':')
  end

  def username_valid
    credentials[0] == 'mayoa'
  end

  def password_valid
    credentials[1] == 'boom'
  end
end

run app