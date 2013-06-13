get '/' do
  @posts = Post.order("created_at DESC LIMIT 50")
  erb :index
end


get '/comments' do
  @all_comments = Comment.order("created_at DESC LIMIT 50")
  erb :comments
end

get '/submit' do
  erb :submit
end

post '/submit' do
  post = Post.create(params[:form])
  post.user = current_user
  post.save
  redirect "/posts/#{post.id}"
end

get '/posts/:post_id' do
  @post = Post.find_by_id(params[:post_id])
  erb :individual_post
end

post '/posts/:post_id' do
  comment = Comment.create(body: params[:body])
  post = Post.find_by_id(params[:post_id])
  comment.user = current_user
  post.comments << comment
  comment.save
  post.save
  redirect "/posts/#{post.id}"
end

get '/users/:user_id' do
  @user = User.find(params[:user_id])
  erb :user
end

post '/users/:user_id' do
  user = User.find(params[:user_id])
  user.update_attributes(params[:form])
  redirect "/users/#{user.id}"
end

get '/login' do
  erb :login
end

post '/login' do
  user = User.authenticate(params[:name], params[:password])
  if user
    session.clear
    session[:user_id] = user.id
    redirect '/'
  else  
    redirect '/login'
  end
end

post '/create' do
  user = User.create(params[:form])
  if user.valid?
    session.clear
    session[:user_id] = user.id
    redirect "/users/#{user.id}"
  else
    redirect '/login'
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

post '/postvote' do
  this_vote = PostVote.find_or_create_by_post_id(params[:form])
  if request.xhr?
    erb :_post_js, layout: false, locals: { post: this_vote.post }
  else
    redirect '/'
  end
end

post '/commentvote' do
  this_vote = CommentVote.find_or_create_by_comment_id(params[:form])
  if request.xhr?
    erb :_comment_js, layout: false, locals: { comment: this_vote.comment }
  else
    redirect '/'
  end
end
