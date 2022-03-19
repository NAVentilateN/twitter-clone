# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Creating test user...'
user = User.create!(
  email: 'test@test.com',
  username: "testtest",
  password: "11111111"
)
puts 'Finished creating test user!'

puts 'Creating 5 user...'
5.times do |i|
  user = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.name,
    password: "11111111"
  )
  puts "#{i + 1}. #{user.email}"
end
puts 'Finished creating users!'


puts 'Creating 5 post...'
5.times do |i|
  post = Post.create!(
    description: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4),
    user: User.all.sample,
    vote: 0
  )
  puts "#{i + 1}. #{post.description}"
end
puts 'Finish creating posts!'

puts 'Creating 50 post...'
50.times do |i|
  User.all.each do |user|
    user.posts.create!(
      description: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4),
      vote: 0
    )
  end
end
puts 'Finish creating posts!'
