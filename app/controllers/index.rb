get '/' do
  @posts = Post.order("created_at DESC LIMIT 50")
  # if user is logged in, pass in session id
  erb :index
end


get '/comments' do
  @all_comments = Comment.order("created_at DESC LIMIT 50")
  erb :comments
end

get '/submit' do
  #submit the form
  erb :submit
end

post '/submit' do
  post = Post.create(params[:form])
  post.user = User.find(2) #current_user
  post.save
  redirect "/posts/#{post.id}"
end

get '/posts/:post_id' do
  @post = Post.find_by_id(params[:post_id])
  erb :individual_post
end

post '/posts/:post_id' do
  comment = Comment.create(params[:body])
  post = Post.find_by_id(params[:post_id])
  comment.user = current_user
  post.comments << comment
  comment.save
  post.save
  redirect "/posts/#{post.id}"
end

get '/users/:user_id' do
  #if you're logged, display edit option
  #if not logged in, see basic info  
  erb :user
end

get '/login' do
  # erb with the forms
  erb :login
end

post '/login' do
  #success:
  # user = User.find_by_name()
  session[:user_id] = user.id
  redirect '/'
  #unsucces: 
  redirect '/login'
end

post '/create' do
  #create new session
  #create new user in DB
  user_id = user.id
  #success: 
  redirect "/users/#{user.id}"
  #unsucces: 
  redirect '/login'
end

get '/logout' do
  #ends user session
  redirect '/'
end
