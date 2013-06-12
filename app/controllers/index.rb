get '/' do
  @all_posts = Post.all  #order("created_at DESC LIMIT 50")
  # if user is logged in, pass in session id
  erb :index
end

get '/submit' do
  #submit the form
  erb :submit
end

post '/submit' do
  # grab information from post submit 
  #  and pass to new post id page
  redirect '/:post_id'
end

get '/posts/:post_id' do
  # find post id and it's comments
  erb :post
end

post '/posts/:post_id' do
  # find post id and it's comments
  # save comment to post
  redirect '/posts/:post_id'
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
  #create new session
  #success: 
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
