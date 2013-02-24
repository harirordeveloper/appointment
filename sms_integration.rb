require 'net/http'
require 'uri'

class SmsIntegration
 def initialize(phone_number,message)
	 @user="kumar.ch";   #your username
    @password="smscountry";  #your password
    @mobilenumbers="91"+phone_number;  #enter Mobile numbers comma seperated
    @message =message;    # "MESSAGE";  #enter Your Message 
    @senderid="smscntry";  #Your senderid
    @messagetype="N";  #Type Of Your Message
    @DReports="Y";  #Delivery Reports
	 puts message
	 puts phone_number
 end
 
  def sendSMS()
    url=URI.parse("http://www.smscountry.com/SMSCwebservice_Bulk.aspx");
    request = Net::HTTP::Post.new(url.path)
    request.set_form_data({'user'=>@user, 'passwd'=>@password, 'mobilenumber'=>@mobilenumbers, 'message'=>@message, 'senderid'=>@senderid, 'mtype'=>@messagetype, 'DR'=>@DReports})
    response = Net::HTTP.new(url.host, url.port).start {|http| http.request(request) }
    # If U are Behind The Proxy Comment Above Line And  Uncomment Below Line, Give The Proxy Ip & Port
    #response = Net::HTTP::Proxy("PROXY IP", PROXYPORT).new(url.host, url.port).start {|http| http.request(request) }
     
    case response
      when Net::HTTPSuccess
        puts response.body
      else
         response.body
         response.error!
    end
  end
end
