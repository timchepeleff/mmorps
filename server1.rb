require "sinatra"
require "pry"
require 'uri'

use Rack::Session::Cookie, {
  secret: "keep_it_secret_keep_it_safe"
}

get "/" do
  redirect '/rps'
end


get '/rps' do
  if session[:p_score].nil?
    session[:p_score] = 0
    session[:c_score] = 0
  end

  erb :index, locals: {}
end


post "/rps" do
  player_choice = params["choice"]
  computer_choice = ["Rock", "Paper", "Scissors"].sample

  if computer_choice == player_choice
    session[:output] = "Tie! No one wins!"
  elsif player_choice == "Paper" && computer_choice == "Rock" || player_choice == "Rock" && computer_choice == "Scissors" || player_choice == "Scissors" && computer_choice == "Paper"
    session[:output] = "#{player_choice} beats #{computer_choice}. Player Wins!"
    session[:p_score] += 1
  else
    session[:output] = "#{computer_choice} beats #{player_choice}. Computer Wins!"
    session[:c_score] += 1
  end

  redirect "/rps"
end

post '/reset' do
  session.clear
  redirect "/rps"
end

