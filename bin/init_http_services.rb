require 'sinatra/base'
require 'json'

Dir["/home/pi/code/raspberry/lib/users/*.rb"].each {|file| require file }
Dir["/home/pi/code/raspberry/lib/device/*.rb"].each {|file| require file }
Dir["/home/pi/code/raspberry/lib/actioners/*.rb"].each {|file| require file }
Dir["/home/pi/code/raspberry/lib/consultors/*.rb"].each {|file| require file }

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
      status 200
      body @user.to_json
    else
      status 401
      body '{"error":"usuario y/o password incorrectos"}'
    end
  end

  post '/iam/*/with/*/update/user_state' do
    authenticate(params[:splat][0],params[:splat][1])
    unless @user.nil?
      data = JSON.parse(request.body.read)
      p data
      dni = params[:splat][0].split('@').first
      UserActioner.update_state(dni,data['state'])
      status 200
    else
      status 500
    end
  end

  get '/iam/*/with/*/do/pulse' do
    content_type :json
    authenticate(params[:splat][0],params[:splat][1])
    unless @user.nil?
        Thread.new do
          device ||= Device.new('192.168.1.181')
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

  run! if app_file == $0
end
