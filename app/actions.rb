require 'pry'
# Homepage (Root path)
enable :sessions

helpers do
  def current_user
    # session[:user_id] ? User.find(session[:user_id]) : nil
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end

get '/' do
  erb :'index'
end

get '/songs' do
  @songs = Song.all
  erb :'songs/index'
end

get '/songs/new' do
  @song = Song.new
  erb :'songs/new'
end

get '/songs/:id' do
  @song = Song.find params[:id]
  erb :'songs/show'
end

post '/songs' do
  @song = Song.new(
    title: params[:title],
    artist: params[:artist],
    url:  params[:url]
  )
  if @song.save
    redirect '/songs'
  else
    erb :'songs/new'
  end
end

get '/users/new' do
  @user = User.new
  erb :'users/new'
end

post '/users/new' do
  @user = User.new(
    name: params[:name],
    password: params[:password],
    password_confirmation: params[:password_confirmation],
    email: params[:email]
  )
  if @user.save
    session[:user_id] = @user.id
    redirect "/songs"
    # redirect "users/confirmation/#{@user.id}"
  else
    erb :'users/new'
  end
end

get '/users/confirmation/:id' do
  @user = User.find(params[:id])
  erb :'users/confirmation'
end

get '/users/login' do
  erb :'users/login'
end

post 'users/login' do
  user = User.where(name: params[:name], password: params[:password]).first
  if user 
    session[:user_id] = user.id 
    redirect '/songs'
  else
    erb :'users/login'
  end
end

post '/users/session' do
  session.clear
  redirect '/songs'
end

post '/songs/:id/upvotes' do
  song = Song.find params[:id]
  song.votes.create(user_id: current_user.id, value: 1)
  redirect '/songs'
  # vote = song.votes.where(user_id: current_user.id).first
  # if vote
  #   if vote.value > 0
  #     vote.value += 0
  #     vote.save!
  #     redirect '/songs'
  #     #erb :'song/vote_error'
  #   else
  #     vote.value += 1
  #     vote.save!
  #     redirect '/songs'
  #   end
  # else
  #   song.votes.create(user_id: current_user.id, value: 1)
  #   redirect '/songs'
  # end
end

post '/songs/:id/downvotes' do
  song = Song.find params[:id]
  vote = song.votes.where(user_id: current_user.id).first
  if vote
    if vote.value < 0
      vote.value -= 0
      vote.save!
      redirect '/songs'
      # erb :'song/vote_error'
    else
      vote.value -= 1
      vote.save!
      redirect '/songs'
    end
  else
    song.votes.create(user_id: current_user.id, value: -1)
    redirect '/songs'
  end
end
