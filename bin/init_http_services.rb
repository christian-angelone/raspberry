require 'sinatra/base'
require 'require_all'
require_all 'lib'

class HttpService < Sinatra::Base

  def authenticate(a_username,a_password)
    @user =  UserConsultor.authenticate(a_username,a_password)
  end

  get '/info' do
    "Edificio Republica,Sala de Transmicion X"
  end

  post '/iam/*/with/*/want/pulse' do
    'pulse'    
  end

  get '/iam/*/with/*/want/last_state' do
    authenticate(params[:splat][0],params[:splat][1])
    unless @user.nil?
      status 200
      body StateLogConsultor.last
    else
      status 203
      body "Usuario no registrado"
    end
  end

  get '/iam/*/with/*/want/states_log' do
    authenticate(params[:splat][0],params[:splat][1])
    unless @user.nil?
      if @user.priviliges['view_states_log']
        status 200
        body StateLogConsultor.all
      else
        status 203
        body "Usted no tiene privilegios para este servicio"
      end
    else
      status 203
      body "Usuario no registrado"
    end
  end

  get '/iam/*/with/*/want/users' do
    authenticate(params[:splat][0],params[:splat][1])
    unless @user.nil?
      if @user.priviliges['crud_users']
        status 200
        body UserConsultor.all
      else
        status 203
        body "Usted no tiene privilegios para este servicio"
      end
    else
      status 203
      body "Usuario no registrado"
    end
  end

  run! if app_file == $0
end
