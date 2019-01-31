require 'sinatra'
require "sqlite3"

# SQLite3::Database.new "true_colors.db"

DB = SQLite3::Database.open "true_colors.db"
DB.results_as_hash = true

#Create a table
# rows = DB.execute <<-SQL
#   create table Games (
#     game_pk integer primary key autoincrement,
#     title text
#   );
# SQL

# # Execute a few inserts
#DB.execute("insert into Games(title) values('Code Names')")


get '/' do
  @title = 'Welcome!'
  erb :index
end

get '/add_game' do
  erb :add_game
end

get '/submit' do
  erb :submit
end

post '/submit' do
  @title = params['title']
  erb :submit
end

get '/library' do
  @games = DB.execute('select game_pk, title from Games')
  erb :library
end


