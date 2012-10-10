require 'rest_client'
require 'rexml/document'

class CrowdUser
  def initialize(username, password)
    begin
      @document = nil
      response = RestClient::Resource.new("#{Setting[:login_link_crowd]}/rest/usermanagement/1/authentication?username=#{username}", :user => Setting[:login_link_basic_username], :password => Setting[:login_link_basic_password]).post "<password><value>#{password}</value></password>", :content_type => 'text/xml'
      @document = REXML::Document.new(response)
    rescue RestClient::Exception
    end
  end
  
  def name
    @document.root.elements['email'].text
  end
  
  def screen_name
    @document.root.elements['display-name'].text
  end
  
  def exist?
    not @document.nil?
  end
end
