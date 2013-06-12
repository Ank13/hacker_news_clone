user_array = []

8.times do
  user_array << User.create(name: Faker::Internet.user_name,
                            about: Faker::Lorem.sentences(sentence_count = (3..7).to_a.sample),
                            password: "pass",
                            email: Faker::Internet.email)  
end

20.times do
  post = Post.create(title: Faker::Lorem.sentence(3), 
                     url: Faker::Internet.url, 
                     text: Faker::Lorem.sentences(sentence_count = (0..7).to_a.sample))
  post.user = user_array.sample
  post.save

  rand(7).times do
    comment = Comment.create(body: Faker::Lorem.sentences(sentence_count = (1..14).to_a.sample))
    post.comments << comment
    comment.user = user_array.sample
    comment.save
  end
end
