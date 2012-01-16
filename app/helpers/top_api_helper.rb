require 'uri'
require 'net/http'
require 'json'
require 'hmac-md5'
require 'cgi'
module TopApiHelper
  def TopApiHelper.sign_request(params, app_secret)
    a = (Hash[*(params.sort).collect {|v| [v,v*2]}.flatten]).map {|k, v| "#{k}#{v}"}.join('')
    HMAC::MD5.hexdigest(app_secret,a).upcase
  end
  
  def TopApiHelper.build_query(params)
    params.map{|k, v| "#{k}=#{CGI.escape(v)}"}.join('&')
  end
  
  public
  def TopApiHelper.taobao_net(method, application_param, appkey, app_secret, session)
    application_param.each {|k, v| application_param.delete(k) if !k || !v || k == "" || v == ""}
    date = Time.new.strftime('%Y-%m-%d %H:%M:%S')
    protocal_must_param = {'timestamp' => date,'v' => '2.0','app_key' => appkey,'method' => method ,'sign_method' => 'hmac' ,'partner_id' => 'top-sdk-java-20111220','format' => 'json'}
    protocal_must_param['session'] = session if session
    protocal_must_param['sign'] = self.sign_request(protocal_must_param.merge(application_param), app_secret)
    must_query = self.build_query(protocal_must_param)
    request_url = 'http://gw.api.taobao.com/router/rest' + '?' + must_query
    Net::HTTP.start((URI.parse(request_url)).host, (URI.parse(request_url)).port) do |http|
      req = Net::HTTP::Post.new(request_url)
      req.set_form_data(application_param,'&')
      responseBody = http.request(req).body
      return yield(JSON.parse(responseBody)) if block_given?
    end
  end
end
