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
  connection.list_processes.each do |pid, user, location, database, command, time, state, info|
    @processes << {
      :pid => pid,
      :user => user,
      :location => location,
      :database => database,
      :command => command,
      :time => time,
      :state => state,
      :info => info
    }
  end

  
  haml :index
end