require 'sass'
require 'sinatra'
require "sqlite3"

get('/styles.css'){ scss :styles }

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
  DB.execute("insert into Games(title) values('#{@title}')")
  erb :submit
end

get '/library' do
  @games = game_list
  erb :library
end

post '/remove_game' do
  delete_game(params['game_pk'])
  redirect '/library'
end

get '/update_game' do
  erb :update_game
end

post '/update_game' do
  @old_title = params['title']
  erb :update_game
end

post '/update' do
  update_game(params['new_title'], params['old_title'])
  redirect '/library'
end

def game_list
  DB.execute('select game_pk, title from Games') || []
end

def delete_game(game_pk)
  DB.execute("delete from Games where game_pk = #{game_pk};")
end

def update_game(new_title, old_title)
  DB.execute("update Games set title = '#{new_title}' where title = '#{old_title}';")
end
 
