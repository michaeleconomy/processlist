# put github address up here

require 'rubygems'
require 'sinatra'
require 'mysql'
require 'haml'

@host = "localhost" #localhost
user = "root"
password = ""

connection = Mysql.connect(@host, user, password)
connection.reconnect = true

get '/' do
  @processes = []
  connection.list_processes.each do |pid, user, ip, status, time, query|
    @processes << {
      :pid => pid,
      :user => user,
      :ip => ip,
      :status => status,
      :time => time,
      :query => query
    }
  end
  
  haml :index
end