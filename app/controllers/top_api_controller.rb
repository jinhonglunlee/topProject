require 'top_api_helper.rb'
require 'yaml'
class TopApiController < ApplicationController
  def index
    admin = YAML.load(File.open("admin.yml"))
    @@appkey = admin['appkey']
    @@app_secret = admin["app_secret"]
    @params = Category.find(params[:id]).functions.find(params[:function_id]).params
    @application_param = {}
    @params.each do |param|
      @application_param[param[:name]] = params[param[:name].gsub('_','.')]
    end
    TopApiHelper.taobao_net(params[:method], @application_param, @@appkey, @@app_secret, session[:sessionKey]) do|json|
    @jsons = json
    end
    render :text => @jsons
  end
end
