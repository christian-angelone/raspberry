require 'sinatra/base'
require 'json'
require 'require_all'
require_all 'lib'

class HttpService < Sinatra::Base

  set :bind, '0.0.0.0'
  set :server, :puma

  def authenticate(a_username,a_password)
    @user =  UserConsultor.authenticate(a_username,a_password)
    p @user
  end

  get '/info' do
    content_type :json
    DeviceInfoConsultor.all
  end

  get '/iam/*/with/*/want/authenticate' do
  
    content_type :json
    authenticate(params[:splat][0],params[:splat][1])
    unless @user.nil?  
      UserActioner.set_online(params[:splat][0],request.ip)
      status 200
      body @user.to_json
    else
      status 401
      body '{"error":"usuario y/o password incorrectos"}'
    end
   end

  get '/iam/*/with/*/do/pulse' do
    content_type :json
    authenticate(params[:splat][0],params[:splat][1])
    unless @user.nil?
        Thread.new do
          device ||= Device.new('192.168.0.55')
          device.pulse
        end
      status 200
      body '{"message":"OK"}'
    else
      status 203
      body '{"error":"usuario no registrado"}'
    end    
  end

  get '/iam/*/with/*/want/last_state' do
    content_type :json
    authenticate(params[:splat][0],params[:splat][1])
    unless @user.nil?
      status 200
      body StateLogConsultor.last
    else
      status 203
      body '{"error":"usuario no registrado"}'
    end
  end

  get '/iam/*/with/*/want/states_log' do
    content_type :json
    authenticate(params[:splat][0],params[:splat][1])
    unless @user.nil?
      if @user.priviliges['view_states_log']
        status 200
        body StateLogConsultor.all
      else
        status 203
        body '{"error":"Usted no tiene privilegios para este servicio"}'
      end
    else
      status 203
      body '{"error":"Usuario no registrado"}'
    end
  end

  get '/iam/*/with/*/want/users' do
    content_type :json
    authenticate(params[:splat][0],params[:splat][1])
    unless @user.nil?
      if @user.priviliges['crud_users']
        status 200
        body UserConsultor.all
      else
        status 203
        body '{"error":"Usted no tiene privilegios para este servicio"}'
      end
    else
      status 203
      body '{"error":"Usuario no registrado"}'
    end
  end

  get '/iam/*/with/*/want/online_users' do
    content_type :json
    authenticate(params[:splat][0],params[:splat][1])
    unless @user.nil?
      if @user.priviliges['crud_users']
        status 200
        body UserConsultor.online_users
      else
        status 203
        body '{"error":"Usted no tiene privilegios para este servicio"}'
      end
    else
      status 203
      body '{"error":"Usuario no registrado"}'
    end
  end

  run! if app_file == $0
end
